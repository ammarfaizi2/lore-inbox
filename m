Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRDPO4y>; Mon, 16 Apr 2001 10:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130900AbRDPO4o>; Mon, 16 Apr 2001 10:56:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51977 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129084AbRDPO41>; Mon, 16 Apr 2001 10:56:27 -0400
Subject: Re: rw_semaphores
To: yodaiken@fsmlabs.com
Date: Mon, 16 Apr 2001 15:56:45 +0100 (BST)
Cc: dhowells@cambridge.redhat.com (David Howells),
        torvalds@transmeta.com (Linus Torvalds),
        andrewm@uow.edu.au (Andrew Morton), bcrl@redhat.com (Ben LaHaise),
        dhowells@redhat.com (David Howells),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20010416083912.C4036@hq.fsmlabs.com> from "yodaiken@fsmlabs.com" at Apr 16, 2001 08:39:12 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pAQr-0000NQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to imagine a case where 32,000 sharing a semaphore was anything but a 
> major failure and I can't. To me: the result of an attempt by the 32,768th locker
> should be a kernel panic. Is there a reasonable scenario where this is wrong?

32000 threads all trying to lock the same piece of memory ? Its not down
to reasonable scenarios its down to malicious scenarios

