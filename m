Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130664AbQKRKiX>; Sat, 18 Nov 2000 05:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131539AbQKRKiO>; Sat, 18 Nov 2000 05:38:14 -0500
Received: from 13dyn189.delft.casema.net ([212.64.76.189]:23559 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130664AbQKRKiC>; Sat, 18 Nov 2000 05:38:02 -0500
Message-Id: <200011181007.LAA12901@cave.bitwizard.nl>
Subject: Re: Linux 2.2.18pre21
In-Reply-To: <E13wWlX-0008Oh-00@the-village.bc.nu> from Alan Cox at "Nov 16,
 2000 09:40:18 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 18 Nov 2000 11:07:56 +0100 (MET)
CC: jesse <jesse@wirex.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > It's simply not good enough to close all directory file descriptors before chrooting.
> > 
> > If calling chroot once you're already in a chroot jail was disallowed, it would stop
> > this attack.
 
> I think the problem here is that some people have the idea that
> chroot is some kind of magical security device. Thats not true at
> all. You can build an environment like that if you wish by closing
> other directory handles and having no suitably priviledged code in
> the chroot area and stuff.

I read about the BSD Jail stuff a while ago. 

It's a nice "operating system class lab project". Estimated time
needed: 40 hours.

This IS the magical security device. 

				Roger. 
-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
