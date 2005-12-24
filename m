Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVLXVio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVLXVio (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 16:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVLXVio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 16:38:44 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59092 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750728AbVLXVin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 16:38:43 -0500
Date: Sat, 24 Dec 2005 22:38:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hans Kristian Rosbach <hk@isphuset.no>
cc: Axel Kittenberger <axel.kittenberger@univie.ac.at>,
       Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org
Subject: Re: Possible Bootloader Optimization in inflate (get rid of 
 unnecessary 32k Window)
In-Reply-To: <1135328036.23862.86.camel@linux>
Message-ID: <Pine.LNX.4.61.0512242235140.29877@yvahk01.tjqt.qr>
References: <200512221352.23393.axel.kernel@kittenberger.net> 
 <20051222173704.GB23411@buici.com>  <1167.81.217.14.229.1135275158.squirrel@webmail.univie.ac.at>
  <20051222183012.GA27353@buici.com>  <1386.81.217.14.229.1135278280.squirrel@webmail.univie.ac.at>
 <1135328036.23862.86.camel@linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > Right.  And the time to perform that one copy is exactly...?
>> >
>> > I doubt that it is a significant percentage of the whole operation.
>> 
>> Well Yes I agree, I guess also it isn't. Its roughly the time you need to
>> copy 1 MB memory around.
>
>I would think this would be a welcome optimization for embedded
>platforms even if not included in mainline. Embedded platforms
>often dont have very fast memory, but nevertheless are
>required to boot ASAP.

Do old i386s count? I've got one that ran 2.6.11 perfectly (even w/o 
-tiny), but kernel decompression is what took most time. (At 3.00 bogomips, 
the world looks quite different!)


Jan Engelhardt
-- 
