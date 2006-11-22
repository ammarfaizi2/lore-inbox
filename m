Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967098AbWKVEpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967098AbWKVEpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 23:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967100AbWKVEpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 23:45:30 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:20073 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S967098AbWKVEp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 23:45:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=jWVeh1vMgtusNKcrqE4tSYY2RGPn2Y9YYJmUdbZkQBLh3snKTMp6FOIQ2n04tFCnv0tVjiYrrwQBlP0B6oWaTB5v1nDyhS8MsdOBtolZIhZwgiO+MbrmLvvAbTasiE9UriBnYGkX55cx21yazgkQsUUo/1dHDdeTSpYXleG0lxk=  ;
X-YMail-OSG: TFSCf24VM1mSqpDHT2sBVKGl_SSg4B_KMbB7_1CJTpl42U4EBahrN.Q_OoagiAm9ql.jwvyM54kXgJnjgF2y3SXIXeFfQvFOMhOYtYFvWT9TOACWsCTDlw--
From: David Brownell <david-b@pacbell.net>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [Bulk] Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Tue, 21 Nov 2006 20:45:22 -0800
User-Agent: KMail/1.7.1
Cc: Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611211013.19127.david-b@pacbell.net> <4563C5B1.2040304@billgatliff.com>
In-Reply-To: <4563C5B1.2040304@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611212045.24581.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 7:36 pm, Bill Gatliff wrote:

> I don't need to REmux, but I don't want to bother setting up the routing 
> manually at all.  I think the GPIO management stuff can do it properly 
> on my behalf, given the information we have to acquire to get the GPIO 
> API to work in the first place.

Yet requesting GPIO_62 still doesn't tell me I have to
update muxing for ball M7 or G20 ... and knowing that for
GPIOs doesn't go anywhere near knowing that for all the
other chip functions.

