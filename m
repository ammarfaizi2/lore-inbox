Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUD1Vko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUD1Vko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUD1ToG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:44:06 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:2791 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264999AbUD1RaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 13:30:19 -0400
Message-ID: <408FEA82.1040309@pacbell.net>
Date: Wed, 28 Apr 2004 10:31:46 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       speedtouch@ml.free.fr
Subject: Re: [linux-usb-devel] Re: USB related oops in 2.6.6-rk2-bk3 (similar
 with 2.6.5)
References: <200403262054.56725@WOLK> <Pine.LNX.4.58.0403272228360.2662@alpha.polcom.net> <Pine.LNX.4.58.0404270115260.5772@alpha.polcom.net> <Pine.LNX.4.58.0404281325250.5272@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0404281325250.5272@alpha.polcom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:
> Is anybody going to look at it? It prevents my system from shuting down.

Looks like one of the problems already fixed in the latest bk-usb.patch
found in the MM kernels ...

- Dave

> On Tue, 27 Apr 2004, Grzegorz Kulewski wrote:
> 
> 
>>Hi,
>>
>>I experienced this oops. I have uhci-hcd and two devices. One is usb 
>>camera (TC111 - probably not supported under linux?) and the 
>>second is speedtouch modem. Everytime I shut down my system (Gentoo) with 
>>2.6.5 and newer I get some oops but system log is down before that and I 
>>have no time to hack start scripts to stop shuting syslog. It occures when  
>>removing some usb modules. So I stopped speedtouch and removed the modules 
>>manually (in stop scripts order I hope). But I have not removed uhci-hcd 
>>module (this module is removed in other part of stop scripts). And... 
>>nothing happened. So I unplugged speedtouch and replugged it back. And I 
>>immendiatelly got atached oops. (I think that I should use ksymoops, but 
>>it is searching for /proc/ksyms that is not present in 2.6 and it does not 
>>like /proc/kallsyms... And it produces nothing but warnings. What options 
>>should I use?)
>>
>>What can I do to help track the problem down?
>>
>>
>>thanks in advance
>>
>>Grzegorz Kulewski
>>
>>
>>PS. I am subscribbed only to LKML, so CC me, please.
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE. 
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
> 


