Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293362AbSCKWJw>; Mon, 11 Mar 2002 17:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293503AbSCKWJn>; Mon, 11 Mar 2002 17:09:43 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:40082 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S293362AbSCKWJe>; Mon, 11 Mar 2002 17:09:34 -0500
Message-Id: <5.1.0.14.2.20020311220700.05a9c1a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 11 Mar 2002 22:10:19 +0000
To: Vojtech Pavlik <vojtech@suse.cz>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] 2.5.6 IDE 19
Cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020311230158.B3167@ucw.cz>
In-Reply-To: <Pine.SOL.3.96.1020311180113.13428A-100000@libra.cus.cam.ac.uk>
 <E16kUED-0001GB-00@the-village.bc.nu>
 <Pine.SOL.3.96.1020311180113.13428A-100000@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:01 11/03/02, Vojtech Pavlik wrote:
>On Mon, Mar 11, 2002 at 06:05:36PM +0000, Anton Altaparmakov wrote:
> > On Mon, 11 Mar 2002, Alan Cox wrote:
> > > > Funny you should mention that point ... The "flagged taskfile code" 
> is a
> > > > project to allow for NATIVE DFT support in Linux.  Nice screw job 
> you did
> > > > to IBM.
> > >
> > > Ok so whats native DFT and where does he (and I for that matter) read 
> about
> > > it ?
> >
> > DFT = Drive Fault Tolerance
>
>Hmmm, I thought it was Drive Fitness test. TLAs ...

Yes, sorry. I had a dim moment... You are of course right.

> > It is an IBM utility which performs extensive diagnostics of a hard drive.
> > At present this is a DOS program which is used via a dos boot disk.
>
>Which is quite enough as it is. Anyway, the diagnostics consist mostly
>of S.M.A.R.T commands plus some seeking and linear reading of the
>surface.
>
> > Have look at the IBM website where you can download this (you can get a dd
> > image of the boot floppy from there, too, if you don't have Windows).
> >
> > The idea behind native DFT is to be able to perform drive diagnostics from
> > within the OS without rebooting with a DOS disk and tying up the system
> > for hours during the checks. The advantages of this combined with IDE/SCSI
> > hot swap are strikingly obvious...
> >
> > The utility also returns a special fault code which in combination with
> > the ibm website allows you to return a faulty disk and obtain a
> > replacement very easily.
>
>Hmm. I stopped believing in the usefulness of the IBM DFT after my IBM
>drive started giving unrecoverable errors reading my swap partition and
>the DFT said that everything was OK later when I ran it ...

Has worked well for a couple of times... (the extended tests anyway, the 
basic test always succeeds for me). DFT was detecting problems (and I was 
running it as I was having problems in Linux), then I upgraded the firmware 
and it no longer detected problems (and the drives have worked happily ever 
after). So I guess it just not perfect but it certainly worked for me.

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

