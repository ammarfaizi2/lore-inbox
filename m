Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293447AbSCKWCc>; Mon, 11 Mar 2002 17:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293317AbSCKWCX>; Mon, 11 Mar 2002 17:02:23 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:47623 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S293362AbSCKWCH>; Mon, 11 Mar 2002 17:02:07 -0500
Date: Mon, 11 Mar 2002 23:01:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
Message-ID: <20020311230158.B3167@ucw.cz>
In-Reply-To: <E16kUED-0001GB-00@the-village.bc.nu> <Pine.SOL.3.96.1020311180113.13428A-100000@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.3.96.1020311180113.13428A-100000@libra.cus.cam.ac.uk>; from aia21@cus.cam.ac.uk on Mon, Mar 11, 2002 at 06:05:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 06:05:36PM +0000, Anton Altaparmakov wrote:
> On Mon, 11 Mar 2002, Alan Cox wrote:
> > > Funny you should mention that point ... The "flagged taskfile code" is a
> > > project to allow for NATIVE DFT support in Linux.  Nice screw job you did
> > > to IBM.
> > 
> > Ok so whats native DFT and where does he (and I for that matter) read about
> > it ?
> 
> DFT = Drive Fault Tolerance

Hmmm, I thought it was Drive Fitness test. TLAs ...

> It is an IBM utility which performs extensive diagnostics of a hard drive.
> At present this is a DOS program which is used via a dos boot disk.

Which is quite enough as it is. Anyway, the diagnostics consist mostly
of S.M.A.R.T commands plus some seeking and linear reading of the
surface.

> Have look at the IBM website where you can download this (you can get a dd
> image of the boot floppy from there, too, if you don't have Windows).
> 
> The idea behind native DFT is to be able to perform drive diagnostics from
> within the OS without rebooting with a DOS disk and tying up the system
> for hours during the checks. The advantages of this combined with IDE/SCSI
> hot swap are strikingly obvious...
> 
> The utility also returns a special fault code which in combination with
> the ibm website allows you to return a faulty disk and obtain a
> replacement very easily.

Hmm. I stopped believing in the usefulness of the IBM DFT after my IBM
drive started giving unrecoverable errors reading my swap partition and
the DFT said that everything was OK later when I ran it ...

-- 
Vojtech Pavlik
SuSE Labs
