Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSKYAxa>; Sun, 24 Nov 2002 19:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSKYAxa>; Sun, 24 Nov 2002 19:53:30 -0500
Received: from twhszms1.wistron.com.tw ([203.65.214.119]:63751 "EHLO
	twhszms1.wistron.com.tw") by vger.kernel.org with ESMTP
	id <S262210AbSKYAx3>; Sun, 24 Nov 2002 19:53:29 -0500
X-Lotus-FromDomain: WISTRON
From: paul_wu@wnexus.com.tw
To: Tommy Reynolds <reynolds@redhat.com>
cc: linux-kernel@vger.kernel.org
Message-ID: <48256C7C.0005853D.00@TWHSZDS1.WISTRON.COM.TW>
Date: Mon, 25 Nov 2002 09:01:05 +0800
Subject: Re: Which embedded linux is better for being a router? eCos?
	 uclinux?
Mime-Version: 1.0
Content-type: text/plain; charset="us-ascii"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




CPU will be MIPS. Does uclinux support multi-processes? Or there is 3rd choice
for such embedded Linux?

Paul





Tommy Reynolds <reynolds@redhat.com> on 2002/11/22 11:25:49 PM
                                                                                
                                                                                
                                                                                


                                                              
                                                              
                                                              
 To:      Paul Wu/WNI/Wistron@Wistron                         
                                                              
                                                              
 cc:      linux-kernel@vger.kernel.org                        
                                                              
                                                              
                                                              
                                                              
 Subject: Re: Which embedded linux is better for being a      
          router? eCos? uclinux?                              
                                                              


This document is classified as     Normal



Overcoming an impressive lethardy, paul_wu@wnexus.com.tw mumbled:

>  Try to make a router running a embedded linux OS, but don't know select which
>  one is better, eCos? uclinux?
>  Does anyone have such experiences?

By far the easiest solution is to use ordinary Linux on a really old,
cheap PC, or a PC-on-a-board.

eCos can be built with the smallest memory and resource footprint of
any of the other techniques, but may not already support the Ethernet
cards or other devices you need: eCos just doesn't have the sheer
number of device drivers as does Linux.

uCLinux would work well enough, as it's intended for cheap-as-dirt
CPU's that lack an MMU. The features it lacks (there is no "fork()"
only "vfork()") can be easily worked around but your application
software may need tweaking.

Without knowing your engineering requirements it is impossible to say
what you need.



