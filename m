Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSI2PkM>; Sun, 29 Sep 2002 11:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbSI2PkM>; Sun, 29 Sep 2002 11:40:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25028 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262780AbSI2PkK>;
	Sun, 29 Sep 2002 11:40:10 -0400
Date: Sun, 29 Sep 2002 17:45:16 +0200
From: Jens Axboe <axboe@suse.de>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Cc: james <jdickens@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929154516.GE1014@suse.de>
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <200209290114.15994.jdickens@ameritech.net> <1033312735.1326.3.camel@aurora.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033312735.1326.3.camel@aurora.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29 2002, Trever L. Adams wrote:
> On Sun, 2002-09-29 at 02:14, james wrote:
> > How many people are sitting on the sidelines waiting for guarantee
> > that ide is not going to blow up on our filesystems and take our
> > data with it. Guarantee that ide is working and not dangerous to our
> > data, then I bet a lot more people will come back and bang on 2.5. 
> 
> I can tell you right now that I am one of these.  I usually would have
> been involved in testing it for my situations/needs several months
> ago, but I have been very leary of the IDE and block changes.  I have
> one machine (a router) that I could test it on if I knew that the
> dangers of IDE and block were at least low and that the IPv4 and
> associated networking connection tracking and NAT stuff worked.

How many accounts of the new block layer corrupting data have you been
aware of? Since 2.5.1-preX when bio was introduced, I know of one such
bug: floppy, due to the partial completion changes. Hardly critical.

-- 
Jens Axboe

