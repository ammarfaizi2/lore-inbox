Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130445AbQKPPfo>; Thu, 16 Nov 2000 10:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbQKPPfY>; Thu, 16 Nov 2000 10:35:24 -0500
Received: from p3EE3C7BE.dip.t-dialin.net ([62.227.199.190]:5124 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S130445AbQKPPfN>; Thu, 16 Nov 2000 10:35:13 -0500
Date: Thu, 16 Nov 2000 15:07:04 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.2.18pre21
Message-ID: <20001116150704.A883@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fre, Nov 10, 2000 at 03:07:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Alan Cox wrote:

> Ok so the PS/2 bug is real and the megaraid mystery continues
> 
> Anything which isnt a strict bug fix or previously agreed is now 2.2.19
> material.

Torsten Hilbrich posted a chroot "bug" that works on 2.2.17 and
2.2.18pre21, it's in de.comp.os.unix.networking, Subject containing
"chroot-Bug in Linux", dated 2000-11-15 20:38:38 local time (+0100).
Its Message-ID: <87bsvhgh4x.fsf_-_@myrkr.in-berlin.de>

It shows a program that saves the cwd -- open(".",...) in an open file,
then chroots to a newly made directory below that, fchdirs back to the
original open file (that is now outside the chroot) and calls upon
chdir("..").

Note that it's NOT related to the current working directory, but to an
open file outside the chroot.

Please comment.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
