Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965444AbWFTDa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965444AbWFTDa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 23:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965449AbWFTDa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 23:30:56 -0400
Received: from meetpoint.leesburg-geeks.org ([66.63.28.250]:55820 "EHLO
	meetpoint.home") by vger.kernel.org with ESMTP id S965444AbWFTDaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 23:30:55 -0400
Message-ID: <44976BED.4050600@leesburg-geeks.org>
Date: Mon, 19 Jun 2006 23:30:53 -0400
From: Ken Ryan <linuxryan@leesburg-geeks.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > You accelerate nothing. Bit heaven? A CPU without a fan will go into
 > > a cold, cold, shutdown, requiring a hardware reset to get it out of
 > > that latched, no internal clock running, mode.
 >
 > Some CPU may do this, others will go via the random-generator mode
 > into the self-deformation-mode instead.

A few years ago Tom's Hardware Guide made a cool video as part of an 
article on thermal emergencies.  The article is here:

http://www.tomshardware.com/2001/09/17/hot_spot/index.html

The test was pulling off the CPU fan and heatsink while playing Quake. 
Granted it's not entirely realistic; I don't imagine the heatsink would 
come of during heavy gameplay (a more reasonable scenario THG mentions 
is the fan/heatsink coming off during shipping) however considering the 
preposterous little tabs AMD specs for their sockets I think sudden 
breakage is not out of the question.

The video shows a PIII coping (halting), a P4 gracefully slowing down, 
and two variants of Athlon self-destructing (smoke and running solder).

Evidently this set of tests convinced AMD to alter how they handled
overtemp on their processors.  The mobos in the test were built 
according to spec in terms of the thermal sensors and protection code in 
the BIOS.  It didn't help; the exposed die of the Athlon ramped up its 
temperature way faster than the sensor could react.

As for the ceramic package cracking, it is certainly possible,  The
ceramic is indeed designed for very high temperatures, but only if 
heated evenly.  Give the package a 200C temperature differential within 
a second or two and thermal expansion is going to do some damage...

I can certainly believe modern processors deal with sudden thermal rise 
better than the ones in the THG video.  However not all of us can afford 
to always have the latest 'n' greatest... :-(

		ken
