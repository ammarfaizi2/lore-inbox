Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264694AbUDVWA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264694AbUDVWA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUDVWAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:00:55 -0400
Received: from ptb-relay01.plus.net ([212.159.14.212]:2319 "EHLO
	ptb-relay01.plus.net") by vger.kernel.org with ESMTP
	id S264694AbUDVWAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:00:54 -0400
Message-ID: <40884165.5030407@mauve.plus.com>
Date: Thu, 22 Apr 2004 23:04:21 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Kim Holviala <kim@holviala.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] psmouse: fix mouse hotplugging
References: <200404221546.i3MFka6w004059@eeyore.valparaiso.cl> <Pine.LNX.4.55.0404221754470.16448@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0404221754470.16448@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> On Thu, 22 Apr 2004, Horst von Brand wrote:
> 
> 
>>>This patch fixes hotplugging of PS/2 devices on hardware which don't
>>>support hotplugging of PS/2 devices. In other words, most desktop
>>
>>machines.
>>
>>I have seen "hoplugging of mice" fry PS/2 ports, and heard of motherboards
>>killed that way. 
> 
> 
>  For older systems, a fuse would often blow on these ports, which
> depending on the implementation would require a power cycle or a soldering
> iron.  Then one of those PCxx specs from Microsoft required the PS/2 ports
> to support hot-plugging, so chances are it may pretty safe with recent
> equipment.

Even for relatively newer kit, wierd stuff can happen.
I recall one keyboard/athlon 500 system that would reboot 10s after the keyboard
was plugged in, about 1% of the time.
Probably a KBC code bug, but unfixable.
