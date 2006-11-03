Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752902AbWKCBTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbWKCBTH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 20:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752908AbWKCBTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 20:19:07 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:34965 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752902AbWKCBTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 20:19:06 -0500
Date: Fri, 3 Nov 2006 02:19:05 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <20061102235920.GA886@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <20061102235920.GA886@wohnheim.fh-wedel.de>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1908636959-203762872-1162516719=:7781"
Content-ID: <Pine.LNX.4.64.0611030218490.7781@artax.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1908636959-203762872-1162516719=:7781
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0611030218491.7781@artax.karlin.mff.cuni.cz>

> On Thu, 2 November 2006 22:52:47 +0100, Mikulas Patocka wrote:
>>
>> new method to keep data consistent in case of crashes (instead of
>> journaling),
>
> Your 32-bit transaction counter will overflow in the real world.  It
> will take a setup with millions of transactions per second and even
> then not trigger for a few years, but when it hits your filesystem,
> the administrator of such a beast won't be happy at all. :)
>
> Jörn

If it overflows, it increases crash count instead. So really you have 2^47 
transactions or 65536 crashes and 2^31 transactions between each crash.

Mikulas
--1908636959-203762872-1162516719=:7781--
