Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315345AbSEBSO3>; Thu, 2 May 2002 14:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315346AbSEBSO2>; Thu, 2 May 2002 14:14:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21518 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315345AbSEBSO1>; Thu, 2 May 2002 14:14:27 -0400
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 2 May 2002 19:33:06 +0100 (BST)
Cc: arjanv@redhat.com (Arjan van de Ven),
        rgooch@ras.ucalgary.ca (Richard Gooch), linux-kernel@vger.kernel.org
In-Reply-To: <3CD16F03.9090900@evision-ventures.com> from "Martin Dalecki" at May 02, 2002 06:53:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173LO6-0004Wm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And then think about the fact that they are able to even *patch*
> running kernels. There is no way I can be convinced that the whole
> versioning stuff is neccessary or a good design for any purpose.

I wouldnt pick Solaris as an example. A long time ago they fixed a bug
in the streams code I found that let anyone reconfigure networking. It was
fixed in a day then not released for a year. It cost Sun a lot because
several customers wisely asked why it hadn't been fixed and went with
other products. To this day Sun has never explained officially why it took
a year to fix but I've been informed off the record by sun people I trust
that it was because it broke their module abi so had to be held over for
the next release

Now I don't actually give a hoot whether you implement the module binding
via /proc/kernel.so and C++ like mangling hacks or the _R stuff we do now
but don't confuse the Linux approach of putting a few million users before
a few binary module ISV's with the Solaris one.

Alan
