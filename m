Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131986AbREEHO4>; Sat, 5 May 2001 03:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132338AbREEHOr>; Sat, 5 May 2001 03:14:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32529 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131986AbREEHOa>; Sat, 5 May 2001 03:14:30 -0400
Subject: Re: Possible PCI subsystem bug in 2.4
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 5 May 2001 08:17:41 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        beamz_owl@yahoo.com (Edward Spidre),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <m1y9scmkg9.fsf@frodo.biederman.org> from "Eric W. Biederman" at May 04, 2001 11:30:30 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vwJy-0000Iq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> O.k.  I was simply thinking that if we weren't reprogramming the mtrrs, it
> would be a good idea to make certain we didn't map any PCI drivers
> into a write back area. 

What if the BIOS set up an mtrr for a device ?
