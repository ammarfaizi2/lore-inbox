Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284243AbRLTLj1>; Thu, 20 Dec 2001 06:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284246AbRLTLjR>; Thu, 20 Dec 2001 06:39:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20484 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284243AbRLTLjO>;
	Thu, 20 Dec 2001 06:39:14 -0500
Date: Thu, 20 Dec 2001 12:39:04 +0100
From: Jens Axboe <axboe@suse.de>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'eject' process stuck in "D" state
Message-ID: <20011220123904.B710@suse.de>
In-Reply-To: <20011220111249.GA15692@wizard.com> <20011220122325.A710@suse.de> <20011220113654.GA1271@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011220113654.GA1271@wizard.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20 2001, A Guy Called Tyketto wrote:
> On Thu, Dec 20, 2001 at 12:23:25PM +0100, Jens Axboe wrote:
> > On Thu, Dec 20 2001, A Guy Called Tyketto wrote:
> > > 
> > >         Hate to be an old bugger and bring this up again, but I just had this 
> > > old problem show up again, with 2.5.1-dj3. The scoop:
> > 
> > Were you using sr or ide-cd when this happened? There seems to be stuff
> > missing from the kernel messages you included, could you please check
> > dmesg for all of it.
> > 
> > Don't worry, it's no shocker if eject isn't working :-)
> 
>         Sorry.. forgot to include that as well. Here's my lsmod output 
> revelant to the problem, at the time of it happening:
> 
> ide-cd                 26816   0 (autoclean)
> sr_mod                 13524   0 (autoclean) (unused)
> cdrom                  29344   0 (autoclean) [ide-cd sr_mod]
> scsi_mod               71544   1 (autoclean) [sr_mod]
> 
>         I manually tried the CD drive's eject button, and of course,
>         it didn't work. The kernel hadn't freed up the device, so
>         there's no reason why it wouldn't have worked.

Great so it could be either, you're really not giving any new
information here :-)

Please tell me what /dev/* is opened by the cd player program and please
include the kernel message as asked, thanks.

-- 
Jens Axboe

