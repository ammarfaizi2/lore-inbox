Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264890AbSKNOn6>; Thu, 14 Nov 2002 09:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSKNOn6>; Thu, 14 Nov 2002 09:43:58 -0500
Received: from windsormachine.com ([206.48.122.28]:33799 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S264890AbSKNOn6>; Thu, 14 Nov 2002 09:43:58 -0500
Date: Thu, 14 Nov 2002 09:50:41 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Jani Averbach <jaa@cc.jyu.fi>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How do I re-activate IDE controller (secondary channel) after
 boot?
In-Reply-To: <Pine.GSO.4.33.0211141339170.12421-100000@tukki.cc.jyu.fi>
Message-ID: <Pine.LNX.4.33.0211140949090.1092-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Jani Averbach wrote:

> My problem is that:
> The bios won't boot at all if I have over 32G hard disk connected, but if
> I disabled secondary IDE channel, it will.

Don't disable the ide channel, set the hard drive type to none in the
bios, instead of auto.  I have 5 or 6 machines that are like that, 120 gig
drives in machines with 32 gig limits, and a few with 8 gig limits

If you are running 2.2.2x, make sure you put Andre's IDE patches in, as it
properly enables the controller to work at full speed, with DMA.

Mike

