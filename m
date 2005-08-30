Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVH3PJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVH3PJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVH3PJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:09:51 -0400
Received: from xenotime.net ([66.160.160.81]:29897 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932179AbVH3PJv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:09:51 -0400
Date: Tue, 30 Aug 2005 08:09:47 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: David Hollis <dhollis@davehollis.com>
cc: Diego Calleja <diegocg@gmail.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       "" <stephane.wirtel@belgacom.net>, "" <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13 : __check_region is deprecated
In-Reply-To: <1125412117.4801.18.camel@dhollis-lnx.sunera.com>
Message-ID: <Pine.LNX.4.50.0508300808480.20387-100000@shark.he.net>
References: <20050829231417.GB2736@localhost.localdomain> 
 <20050830012813.7737f6f6.diegocg@gmail.com>  <9a8748490508291634416a18bc@mail.gmail.com>
  <20050830015513.62ee2c0c.diegocg@gmail.com> <1125412117.4801.18.camel@dhollis-lnx.sunera.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005, David Hollis wrote:

> On Tue, 2005-08-30 at 01:55 +0200, Diego Calleja wrote:
> > El Tue, 30 Aug 2005 01:34:25 +0200,
> > Jesper Juhl <jesper.juhl@gmail.com> escribió:
> >
> > > I don't see why we should break a bunch of drivers by doing that.
> > > Much better, in my oppinion, to fix the few remaining drivers still
> > > using check_region and *then* kill it. Even unmaintained drivers may
> >
> > I'd usually agree with you, but check_region has been deprecated for so many
> > time; I was just wondering myself if people will bother to fix the remaining
> > drivers without some "incentive"
>
> Shouldn't it be (or have been) added to the
> Documentation/feature-removal-schedule.txt then so it could be
> deprecated and removed through the proper mechanisms.

It should be (or have been) if there were a hard plan and
deadline to remove it, but there isn't, and there needn't be,
so it's not missing from there IMO.

-- 
~Randy
