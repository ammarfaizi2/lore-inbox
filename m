Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280937AbRKOQmU>; Thu, 15 Nov 2001 11:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280935AbRKOQmK>; Thu, 15 Nov 2001 11:42:10 -0500
Received: from unthought.net ([212.97.129.24]:11731 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S280932AbRKOQlv>;
	Thu, 15 Nov 2001 11:41:51 -0500
Date: Thu, 15 Nov 2001 17:41:50 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux i/o tweaking
Message-ID: <20011115174150.B23020@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011115172246.Z27010@suse.de> <Pine.LNX.4.30.0111151731280.13922-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0111151731280.13922-100000@mustard.heime.net>; from roy@karlsbakk.net on Thu, Nov 15, 2001 at 05:32:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 05:32:29PM +0100, Roy Sigurd Karlsbakk wrote:
> > Could you please try and profile where the time is spent? Boot with
> > profile=2, and then do
> >
> > # readprofile -r
> > # do I/O testing
> > # readprofile | sort -nr
> 
> I will.
> 
> However ... Is it normal for a server to max out 2xPIII 1266MHz CPUs by
> reading from software RAID-5???

Certainly not.

Well, if you down-scale the experiment it's not.  Reading 10.7 MB/sec
will not consume 10% of your two processors.

But queue systems are evil   ;)   I look forward to seeing the profile.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
