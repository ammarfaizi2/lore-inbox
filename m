Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSLAOe4>; Sun, 1 Dec 2002 09:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSLAOe4>; Sun, 1 Dec 2002 09:34:56 -0500
Received: from mgr5.xmission.com ([198.60.22.205]:38238 "EHLO
	mgr5.xmission.com") by vger.kernel.org with ESMTP
	id <S261839AbSLAOey>; Sun, 1 Dec 2002 09:34:54 -0500
Message-ID: <3DEA1FCB.1040603@xmission.com>
Date: Sun, 01 Dec 2002 07:42:19 -0700
From: Frank Jacobberger <f1j1@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andy@ajsoft.net
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 DRM/DRI issue with Radeon
References: <20021201143233.MIKG4739.fep01-svc.ttyl.com@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Jefferson wrote:

>>>In the 2.4.20 kernel changelog I see comments about having consistent
>>>DRM modules with XFree4.2.0. I have a Radeon Mobility M6 LY in a Dell
>>>laptop and would like to get DRI working. Whenever I use any 2.4.*
>>>(including 2.4.20) kernel I get the following messages in
>>>/var/log/XFree86.0.log, and DRM is not enabled. Is this supposed to be
>>>working in 2.4.20 ? I am using a Mandrake 8.2 system (except for the
>>>kernel).
>>>(EE) RADEON(0): [dri] RADEONDRIScreenInit failed because of a version mismatch.
>>>[dri] radeon.o kernel module version is 1.1.1 but version 1.2.x is needed.
>>>[dri] see http://gatos.sf.net/ for an updated module
>>>[dri] Disabling DRI.
>>>      
>>>
>
>
>  
>
>>Works for me.
>>Debian GNU/Linux unstable distribution
>>
>>You did enable radeon DRM drivers in the kernel config right? For your
>>chipset and for the Radeon, right?
>>    
>>
>
>Well, yes. I'm getting VERSION CONFLICT messages, and not that there is no radeon.o module. For the record, 
>what I get from dmesg is
>
>Linux agpgart interface v0.99 (c) Jeff Hartmann
>agpgart: Maximum main memory to use for agp memory: 203M
>agpgart: Detected Intel i830M chipset
>agpgart: AGP aperture is 256M @ 0xd0000000
>[drm] AGP 0.99 on Unknown @ 0xd0000000 256MB
>[drm] Initialized radeon 1.1.1 20010405 on minor 0
>
>FWIW I have in the kernel
>
>/dev/agpgart set to Module
>I830M support set to Yes
>Build old DRM 4.0 drivers set to No
>DRM 4.1 ATI Radeon set to Module
>
>So the version of the kernel module is 1.1.1 20010405 (with 2.4.19, AND 2.4.20) , yet the XFree86 drivers need 1.2.* as per the original message in the XFree86.0.log. Why is the kernel using 1.1.1 and not 1.???
>
You need to grab the later drm kernel.

>  
>

