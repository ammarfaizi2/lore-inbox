Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293424AbSCKWDM>; Mon, 11 Mar 2002 17:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293362AbSCKWDD>; Mon, 11 Mar 2002 17:03:03 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:49671 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S293424AbSCKWC5>; Mon, 11 Mar 2002 17:02:57 -0500
Date: Mon, 11 Mar 2002 23:02:50 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
Message-ID: <20020311230250.C3167@ucw.cz>
In-Reply-To: <Pine.SOL.3.96.1020311180113.13428A-100000@libra.cus.cam.ac.uk> <E16kVdS-0001U0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16kVdS-0001U0-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 11, 2002 at 07:39:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 07:39:06PM +0000, Alan Cox wrote:
> > The idea behind native DFT is to be able to perform drive diagnostics from
> > within the OS without rebooting with a DOS disk and tying up the system
> > for hours during the checks. The advantages of this combined with IDE/SCSI
> > hot swap are strikingly obvious...
> 
> So providing we have a properly generic "issue IDE command from user space"
> do we need any more kernel magic for this ?

That's all we need, yes. And I hope that's exactly what we'll have.

-- 
Vojtech Pavlik
SuSE Labs
