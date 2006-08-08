Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWHHP04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWHHP04 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWHHP04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:26:56 -0400
Received: from mga07.intel.com ([143.182.124.22]:34894 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S964947AbWHHP0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:26:54 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.07,222,1151910000"; 
   d="scan'208"; a="100320179:sNHT17991771"
Message-ID: <44D8AD3D.60402@linux.intel.com>
Date: Tue, 08 Aug 2006 08:26:53 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev <netdev@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2: bad e1000 device name
References: <44D78A48.7050707@goop.org> <20060808004011.ab3cd65f.akpm@osdl.org> <44D8484E.9050904@goop.org> <44D8AB08.3000006@linux.intel.com> <44D8ACFE.3060802@goop.org>
In-Reply-To: <44D8ACFE.3060802@goop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Arjan van de Ven wrote:
>> Jeremy Fitzhardinge wrote:
>>> Andrew Morton wrote:
>>>> e1000 seems OK here.  Don't know, sorry.
>>>>   
>>>
>>> It's happening to all my ethernet-like devices: the Atheros wireless 
>>> comes up as a mess too.  It's different each time, so it looks like 
>>> random uninitialized crud.
>>>
>>
>> is this the binary atheros driver? then please try without that.. 
> 
> It happens regardless of whether the atheros driver is loaded (or has 
> ever been loaded).  But it also happens to the atheros driver, so it 
> isn't specific to the e1000.
> 

and you're also sure this is not your userspace using interface renaming...
(could be an initscripts bug for name-by-MAC ethernet device naming)
