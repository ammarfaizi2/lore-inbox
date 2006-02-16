Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160994AbWBPML0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160994AbWBPML0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 07:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWBPMLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 07:11:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18951 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030374AbWBPMLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 07:11:25 -0500
Date: Thu, 16 Feb 2006 13:11:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marc Koschewski <marc@osknowledge.org>
Cc: Ross Vandegrift <ross@jose.lug.udel.edu>, Christian <christiand59@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
Message-ID: <20060216121123.GD3511@stusta.de>
References: <20060214135016.GC10701@stusta.de> <200602141659.40176.christiand59@web.de> <20060214164002.GC5905@stiffy.osknowledge.org> <20060214184708.GA29656@lug.udel.edu> <20060215133523.GA6628@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215133523.GA6628@stiffy.osknowledge.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 02:35:23PM +0100, Marc Koschewski wrote:
> * Ross Vandegrift <ross@lug.udel.edu> [2006-02-14 13:47:08 -0500]:
> 
> > On Tue, Feb 14, 2006 at 05:40:03PM +0100, Marc Koschewski wrote:
> > > Is that maybe dependant on _what_ version of Samba is running on the receiving
> > > end?
> > 
> > I've seen it copying to Windows 2k3.  Only uploading large files, and
> > it's not every time.  I'd say 50% of the time, my box freezes when
> > copying something around 100MiB or larger.
> > 
> > IIRC, my workstation at the office is running 2.6.15.1 or .4.
> 
> I moved to CIFS because SMB didn't work well for me, as well as did NFS. Both
> seems to stall in a way, I could never really reproduce. But CIFS is very stable
> over here. Never ever had a problem with it, whereas both NFS and SMB are likely
> to cause trouble at least once a week. Without log records, without any chance
> of recovery. Mostly hard-freezes.

The problems are often error paths.

I might be running in some unusual error paths in CIFS, and the same 
might be true for you in the SMB and NFS cases.

The SMB file system in the kernel is unfrtunately unmaintained, but NFS 
is well maintained. Have you sent a bug report for your NFS problems 
similar to my bug report for my CIFS problems?

> Marc

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

