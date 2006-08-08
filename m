Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWHHPZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWHHPZm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWHHPZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:25:42 -0400
Received: from gw.goop.org ([64.81.55.164]:4266 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964948AbWHHPZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:25:41 -0400
Message-ID: <44D8ACFE.3060802@goop.org>
Date: Tue, 08 Aug 2006 08:25:50 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@linux.intel.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev <netdev@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2: bad e1000 device name
References: <44D78A48.7050707@goop.org> <20060808004011.ab3cd65f.akpm@osdl.org> <44D8484E.9050904@goop.org> <44D8AB08.3000006@linux.intel.com>
In-Reply-To: <44D8AB08.3000006@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Jeremy Fitzhardinge wrote:
>> Andrew Morton wrote:
>>> e1000 seems OK here.  Don't know, sorry.
>>>   
>>
>> It's happening to all my ethernet-like devices: the Atheros wireless 
>> comes up as a mess too.  It's different each time, so it looks like 
>> random uninitialized crud.
>>
>
> is this the binary atheros driver? then please try without that.. 

It happens regardless of whether the atheros driver is loaded (or has 
ever been loaded).  But it also happens to the atheros driver, so it 
isn't specific to the e1000.

    J
