Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSGLA3d>; Thu, 11 Jul 2002 20:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSGLA3c>; Thu, 11 Jul 2002 20:29:32 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:20633 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313867AbSGLA3b>;
	Thu, 11 Jul 2002 20:29:31 -0400
Message-ID: <3D2E235E.1060701@candelatech.com>
Date: Thu, 11 Jul 2002 17:31:26 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clemens Schwaighofer <cs@pixelwings.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Athlon + Athlon optimized kernel => _mmx_mmcpy problems
References: <Pine.LNX.4.44.0207111448450.3904-100000@lynx.piwi.intern>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer wrote:
> Hi,
> 
> I thought, as I have an Athlon, I should recompile my 2.4.18-ac3 kernel 
> for Athlon optimzied ... yadda ... but this causes serious problems.
> 
> After booting, it has quite a lot of depmod problems, with depmod -e it 
> shows all are '_mmx_mmcpy' and vmware can't compile, cause of the same 
> error.
> 
> so I had to go back to PIII style ... or I wouldn't have been able to 
> update vmware ... sad thing
> 

I had this same problem untill I did a make mrproper and re-built from
scratch.  Some part of the build system seems to be the problem (make clean
does not help)

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


