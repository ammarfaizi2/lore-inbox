Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277054AbRJKXYo>; Thu, 11 Oct 2001 19:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277065AbRJKXYf>; Thu, 11 Oct 2001 19:24:35 -0400
Received: from unthought.net ([212.97.129.24]:56455 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S277054AbRJKXYX>;
	Thu, 11 Oct 2001 19:24:23 -0400
Date: Fri, 12 Oct 2001 01:24:54 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Dylan Griffiths <dylang+kernel@thock.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: HPT 370 / RAID 5 possible corruption issue.]
Message-ID: <20011012012453.C6330@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Dylan Griffiths <dylang+kernel@thock.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BC381DE.4090300@thock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3BC381DE.4090300@thock.com>; from dylang+kernel@thock.com on Tue, Oct 09, 2001 at 05:01:50PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 05:01:50PM -0600, Dylan Griffiths wrote:
...
> 	Hi.  I have an HPT 370 in a box here.  It has 2 Quantum drives connectod to
> it (one master per channel) that are in a RAID 5 set with two more
> Quantums on the VIA onboard IDE controller.  When I run an md5sum of a
> group of files vs. the precomputed md5sums, sometimes they don't match in
> different spots.
> 
> 	After googling around the web, I found a similar report with the HPT 366
> controller and software RAID:
> http://www.linux-consulting.com/Raid/Docs/raid_highload.tst.txt
> 
> In there, the fellow found that reading from a drive connected to the HPT
> 366 controller would have different results depending on load.

I can't say what the current status is.   But some time ago some people I know
got burnt with silent corruption from using HPT cards with RAID5 and RAID0, the
cards were replaced with Promise cards, and the problem went away (as it should
- I've been running a lot of RAID on Promise cards and never saw the problem).

As long as there are Promise cards to get, I'm not going anywhere near HPT.

Maybe there's a fix somewhere, maybe there's a magic BIOS setting or upgrade,
maybe something else can make it work, I don't know.  Promise cards are cheap
so I don't care.

Sorry for not being able to give you "good" information, but at least now you
got "some" information.   Hope it helps, for what it's worth.

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
