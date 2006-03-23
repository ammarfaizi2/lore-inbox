Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWCWH4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWCWH4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 02:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWCWH4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 02:56:40 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:29165 "EHLO
	hades.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S1030190AbWCWH4j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 02:56:39 -0500
From: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
To: linux-kernel@vger.kernel.org
Subject: Re:swap prefetching merge plans
Date: Thu, 23 Mar 2006 08:56:24 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603230856.24091.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am just a user, but I would love to see this feature.

After compiling stuff, I have usually some kb in swap (300kb, 360 kb), and 
lots of free ram. But even this few kb make my KDE desktop extremly sluggish. 
It feels, like every byte is fetched individually and always the wrong stuff 
ends in swap.

The only 'workaround' so far is to do a 'swapoff -a&& swapon -a' which not 
only clears swap, but make my box blazzingly fast again (thank you guys, 
besides this little swap annoyance you all do a great job). 

So everything that makes the situation better (swap in of data faster) is 
highly welcome. The CPU is bored most of the time anyway and as I wrote 
above, usually lots of ram are free. So why not use the free ram and free CPU 
cycles?

The compelling argument is: swap is extremly slow. It is so slow that you can 
go out, plant a tree, build a house and father a son while I am waiting for 
some few kb to get fetched from it. Everything that reduces swap access when 
the data is needed, is IMHO a good thing. Oh, and the harddisk is not slow. 
Only swap is.

Glück Auf,
Volker
