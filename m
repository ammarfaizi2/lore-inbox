Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWBVMPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWBVMPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWBVMPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:15:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57358 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751080AbWBVMPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:15:45 -0500
Date: Wed, 22 Feb 2006 13:15:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060222121542.GE4661@stusta.de>
References: <20060214182238.GB3513@stusta.de> <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr> <20060217163802.GI4422@stusta.de> <93564eb70602191933x2a20ce0m@mail.gmail.com> <20060220132832.GF4971@stusta.de> <20060222013410.GH20204@MAIL.13thfloor.at> <20060222023121.GB4661@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <20060222120121.GA5650@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222120121.GA5650@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 01:01:21PM +0100, Herbert Poetzl wrote:
> On Wed, Feb 22, 2006 at 04:10:01AM +0100, Adrian Bunk wrote:
>...
> > Except for the X86_P4_CLOCKMOD case, all of your examples are correct 
> > usages of EMBEDDED.
> 
> ahem, well, then I'm definitely doing something
> wrong when I disable the VGA console on my 2GB
> servers, as "there's no reason to enable EMBEDDED
> when building a kernel for systems with > 50 MB RAM"
> 
> sorry, I kind of disagree here, this might be useful
> for embedded systems, but it is definitely useful
> for other systems as well ... at least I do not like
> the 'assumption' that every system with >50MB has
> to have a VGA console ...
> 
> I agree that the 0815 distro will not need this and
> it can be hidden behind some option ...

It's not assumed that every system with > 50 MB has a VGA console.

These are options where accidentially disabling only causes problems for 
the majority of users.

You can enable EMBEDDED on your 2 GB servers if you really want to save 
a few bytes in the kernel, but OTOH I doubt there is much practival 
value in reducing the kernel for a system with 2 GB RAM by a few kB.

> best,
> Herbert
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

