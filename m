Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289388AbSAVVxL>; Tue, 22 Jan 2002 16:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289402AbSAVVww>; Tue, 22 Jan 2002 16:52:52 -0500
Received: from unthought.net ([212.97.129.24]:10444 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S289387AbSAVVwd>;
	Tue, 22 Jan 2002 16:52:33 -0500
Date: Tue, 22 Jan 2002 22:52:32 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Alok K. Dhir" <alok@dhir.net>, linux-kernel@vger.kernel.org
Subject: Re: Autostart RAID 1+0 (root)
Message-ID: <20020122225232.D11697@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Bill Davidsen <davidsen@tmr.com>, "Alok K. Dhir" <alok@dhir.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020122184600.C11697@unthought.net> <Pine.LNX.3.96.1020122150722.28222A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.96.1020122150722.28222A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Tue, Jan 22, 2002 at 03:12:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 03:12:07PM -0500, Bill Davidsen wrote:
> On Tue, 22 Jan 2002, [iso-8859-1] Jakob Østergaard wrote:
> 
> > On Tue, Jan 22, 2002 at 12:15:28PM -0500, Bill Davidsen wrote:
> 
> > I think he is referring to software RAID. And yes, it is indeed a problem
> > that the RedHat installer cannot create nested RAIDs (at least, I too was
> > unable to do that, so either it's impossible, or I'm equally blind).
> 
>   The RH installer also won't do RAID from a text install, so if you lack
> memory or the right graphic card you just can't do the install at all
> (unless I miss something). What good is install from serial console if you
> can't use any setup but the big blob?

I was able to set up RAID in text-mode from bootnet.img on a low-end pentium
yesterday.  But that was RedHat 7.2, and I think that earlier versions didn't
allow that.  Are you sure you tried this with 7.2 ?

> 
> > 
> > > This is because if the first disk fails totally, the 2nd will be used to
> > > boot. You also should use an initrd image to be sure all you need to get
> > > up is on that small mirrored partition. After that your other partitions
> > > can be whatever pleases you.
> > 
> > Also, GRUB/LILO only support booting from RAID-1 (or no RAID).
> 
>   Another factor, for sure. Fortunately I believe only the boot partition
> needs to be RAID-1, after that the kernel should take over.

Yep.


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
