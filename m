Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130537AbQKTFTe>; Mon, 20 Nov 2000 00:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131234AbQKTFTZ>; Mon, 20 Nov 2000 00:19:25 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:63250 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130537AbQKTFTK>; Mon, 20 Nov 2000 00:19:10 -0500
Date: Sun, 19 Nov 2000 22:45:32 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre22
Message-ID: <20001119224532.B29253@vger.timpanogas.org>
In-Reply-To: <20001119015303.A25697@vger.timpanogas.org> <E13xU2L-0002i3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E13xU2L-0002i3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Nov 19, 2000 at 12:57:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 12:57:35PM +0000, Alan Cox wrote:
> > > o	Small ISDN documentation fixes			(Kai Germaschewski)
> > 
> > Alan, On the ISDN issue, isdn4K-utils seems to be out of sync with=20
> > kernels older than 2.2.16.   Some #define's that used to be in
> > the 2.2.14 patch don't seem to be in 2.2.17 >.  At present, requires
> > an ugly .config patch to work under 2.2.18-21. =20
> 
> Shouldn't do. ISDN has changed between 2.2.16 and 2.2.18pre22 but not in any
> way I am aware is bad. 2.2.19 has the merge of the rest of the isdn changes
> queued.


The Latest tar.gz in isdn4k-utils.src.rpm will not build.  I went to 
ftp.isdn4linux.de and found the latest they have posted and the following 
errors are reported from the build.

Against 2.4.0-10(11)     isdn4k-utils-v3.1pre1.tar.gz

ISDN_MODEM_ANZREG is undeclared in usr/src/linux/include/

Against 2.2.18-22        same

same problem

Jeff


> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
