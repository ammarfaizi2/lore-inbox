Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbTAVXoS>; Wed, 22 Jan 2003 18:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbTAVXoS>; Wed, 22 Jan 2003 18:44:18 -0500
Received: from luna.rtfmconsult.com ([202.83.72.190]:27781 "EHLO
	luna.rtfmconsult.com") by vger.kernel.org with ESMTP
	id <S264697AbTAVXoS>; Wed, 22 Jan 2003 18:44:18 -0500
Date: Thu, 23 Jan 2003 09:53:21 +1000 (EST)
From: jason andrade <jason@rtfmconsult.com>
To: Jacek Radajewski <jacek@usq.edu.au>
Cc: Seth Mos <knuffie@xs4all.nl>, "" <linux-poweredge@dell.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: RE: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
In-Reply-To: <08D7835AE15D6F4BABB5C46427F018DF0E608E@babbage.usq.edu.au>
Message-ID: <Pine.GSO.4.50.0301230948210.772-100000@luna.rtfmconsult.com>
References: <08D7835AE15D6F4BABB5C46427F018DF0E608E@babbage.usq.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, Jacek Radajewski wrote:

> is the network card really the problem ?  I don't want to be replacing all my network cards if the problem is elsewhere .... if you can understand the oops message please, please, please let me know where the problem is ...
>

Jacek,

To date there are about 20 replies that say they have had some degree of problems
with broadcom chipset based network interfaces and about 2 that say it works without
any problems for them.  All of the people having problems say it ranges from interface
issues, to causing the entire machine to panic or worse, to hang until power cycled
or reset.

Based on the information supplied i am inclinced to think there are issues with the
broadcom chipset despite the best efforts of people like Jeff Garzik to address
this (but perhaps he can step in and comment as he knows more since he's the one
writing/supporting/fixing the drivers at redhat :-)

To date, a lot of people have said that they disable the onboard broadcom nics and
use intel e1000s instead.  We have been using the Intel e100/e1000s (with the
intel supplied drivers dropped in, not the default redhat ones) for 2+ years now
at planetmirror.com without any problems.  Those cards are doing between 70 and
100Mbit/sec (and more) 24 by 7 for 2+ years now.

regards,

-jason

