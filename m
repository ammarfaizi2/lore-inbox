Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132380AbQKSPyn>; Sun, 19 Nov 2000 10:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132418AbQKSPye>; Sun, 19 Nov 2000 10:54:34 -0500
Received: from d-dialin-2670.addcom.de ([213.61.81.30]:19182 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S132380AbQKSPyQ>; Sun, 19 Nov 2000 10:54:16 -0500
Date: Sun, 19 Nov 2000 16:09:01 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <isnd4linux@listserv.isdn4linux.de>
Subject: Re: Linux 2.2.18pre22
In-Reply-To: <20001119015303.A25697@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.30.0011191558320.1224-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, Jeff V. Merkey wrote:

> > o	Small ISDN documentation fixes			(Kai Germaschewski)
>
> Alan, On the ISDN issue, isdn4K-utils seems to be out of sync with
> kernels older than 2.2.16.   Some #define's that used to be in
> the 2.2.14 patch don't seem to be in 2.2.17 >.  At present, requires
> an ugly .config patch to work under 2.2.18-21.

It'ld be nice if you at least CC'ed your mail to the maintainers, i.e. the
isdn4linux people, because not everyone has the time to follow l-k.
Any way, I CC'ed isdn4linux@listserv.isdn4linux.de now, and this thread
should continue there.

Could you please clarify which problems you have? You state that the utils
seem to be out of sync with kernels < 2.2.16, but you need to patch them
for kernels > 2.2.17 ?

I just tried the latest "release" of the utils,
isdn4k-utils.v3.1pre1.tar.gz, and the current CVS version against
2.2.18pre22, and they compile fine. Note that binary compatibility didn't
break during 2.2, only for 2.4. (I.e. utils compiled on 2.2 will complain
if used with 2.4, utils compiled on 2.4 will work on either kernel series)

I'm sure, if you provide more details, and the exact error message you're
seeing, we'll find a solution.

--Kai



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
