Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129839AbRCCXNV>; Sat, 3 Mar 2001 18:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129840AbRCCXNL>; Sat, 3 Mar 2001 18:13:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21004 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129839AbRCCXM7>; Sat, 3 Mar 2001 18:12:59 -0500
Subject: Re: [PATCH] 2.4.2: cure the kapm-idled taking (100-epsilon)% CPU time
To: fg@mandrakesoft.com (Francis Galiegue)
Date: Sat, 3 Mar 2001 23:16:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        kernel@linux-mandrake.com (Kernel list)
In-Reply-To: <Pine.LNX.4.21.0103040000550.922-200000@toy.mandrakesoft.com> from "Francis Galiegue" at Mar 04, 2001 12:03:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ZLG0-0004I5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As attachment. Don't ask me why it works. Rather, if you see why it works, I'd
> like to know why :)

Why are you breaking kapm-idled. It is supposed to take all that cpu time. You
just broke all the power saving

