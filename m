Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUAEW2l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265982AbUAEW0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:26:38 -0500
Received: from s383.jpl.nasa.gov ([137.79.94.127]:20618 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP id S265979AbUAEW0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:26:19 -0500
Message-ID: <3FF9E468.9090402@jpl.nasa.gov>
Date: Mon, 05 Jan 2004 14:25:44 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh-sg, zh-tw, ja
MIME-Version: 1.0
To: Tim Connors <tconnors+linuxkernel1073186591@astro.swin.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org> <slrn-0.9.7.4-25573-3125-200401041423-tc@hexane.ssi.swin.edu.au>
In-Reply-To: <slrn-0.9.7.4-25573-3125-200401041423-tc@hexane.ssi.swin.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [1] Others say that it only affects them first time through - after
> something is cached, it goes back to normal speed. For me - it is slow
> *all* the time. If I pipe it to cat or tail or something, it is a
> *lot* quicker.

I get slow all the time at home with a single CPU system.

At work I have a Dual p4 1.7Ghz XEON... Only when I keep both CPU's busy 
(example: make -j 4) does it happen on the dual machine. So basically if 
my dual machine is busy (one CPU has to be pegged or both are over 50% 
usage) I start getting very crappy xterm/gnome-terminal response.

I've been running each xterm/gnome-terminal with screen and when it 
starts grinding I detach/reattach.

-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry and Large Optical Systems
Phone: 818 354 2903
driver@jpl.nasa.gov

