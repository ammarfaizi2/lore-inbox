Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVHYACV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVHYACV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVHYACV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:02:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25338 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932375AbVHYACU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:02:20 -0400
Message-ID: <430D0A80.7020204@mvista.com>
Date: Wed, 24 Aug 2005 17:02:08 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Wilkerson, Bryan P" <Bryan.P.Wilkerson@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kgdbwait in 2.6.13-rc4-mm1?
References: <194B303F2F7B534594F2AB2D87269D9F06DE070A@orsmsx408>
In-Reply-To: <194B303F2F7B534594F2AB2D87269D9F06DE070A@orsmsx408>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilkerson, Bryan P wrote:
> Is there an equivalent kernel boot option for kgdbwait in
> 2.6.13-rc4-mm1?  I grep'd the kernel source but didn't find kgdbwait.
> 
> Is there any documentation other than the source for the flavor of KGDB
> that is included in the akpm kernel patch?   

The patch has some documentation at Documentation/i386/kgdb/* as well as 
a couple of gdb macros...

The wait option is "gdb".  This has been in flux so, to be absolutely 
sure, look at include/asm-i386/bugs.h
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
