Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316693AbSGBKZm>; Tue, 2 Jul 2002 06:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSGBKZl>; Tue, 2 Jul 2002 06:25:41 -0400
Received: from unthought.net ([212.97.129.24]:17897 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S316693AbSGBKZj>;
	Tue, 2 Jul 2002 06:25:39 -0400
Date: Tue, 2 Jul 2002 12:28:05 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lilo/raid?
Message-ID: <20020702102805.GA23296@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Zwane Mwaikambo <zwane@mwaikambo.name>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <3D216157.FC60B17E@aitel.hist.no> <Pine.LNX.4.44.0207021111050.21320-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0207021111050.21320-100000@netfinity.realnet.co.sz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 11:12:03AM +0200, Zwane Mwaikambo wrote:
> On Tue, 2 Jul 2002, Helge Hafting wrote:
> 
> > > > /dev/md1                swap                    swap    defaults        0 0
> > > 
> > > One small thing, you do know that you can interleave swap?
> > 
> > There are sometimes reasons not to do that.
> > Heavy swapping may be caused by attempts to cache 
> > massive io on some fs.  You better not have swap
> > on that heavily accessed spindle - because then
> > everything ends up waiting on that io.
> > 
> > Keeping swap somewhere else means other programs
> > just wait a little for swap - undisturbed by the massive
> > io also going on.
> 
> True, but what i meant was that instead of creating a RAID device to swap 
> to, he could have just interleaved normal swap partitions and gotten the 
> same effect.

If it is a RAID-1 device, there are very good reasons for creating a
RAID device for the swapping  :)

But other than that, you are right. There is no reason for creating a
RAID-0 device for swapping.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
