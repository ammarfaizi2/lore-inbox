Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUCKRQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 12:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbUCKRQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 12:16:59 -0500
Received: from 69-90-55-107.fastdsl.ca ([69.90.55.107]:56193 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id S261564AbUCKRQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 12:16:58 -0500
Message-ID: <4050A047.9030603@brad-x.com>
Date: Thu, 11 Mar 2004 12:22:15 -0500
From: Brad Laue <brad@brad-x.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ksoftirqd using mysteriously high amounts of CPU time
References: <404F85A6.6070505@brad-x.com>	 <20040310155712.7472e31c.akpm@osdl.org> <4050271C.3070103@brad-x.com>	 <40503120.9000008@brad-x.com>  <20040311020832.1aa25177.akpm@osdl.org> <1079013947.24999.17.camel@firefly>
In-Reply-To: <1079013947.24999.17.camel@firefly>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yury V. Umanets wrote:
> Hello,
> 
> I have impression, that it is somehow related to ACPI and CPU
> temperature. When CPU gets more hot ksoftirqd starts to eat 99% of CPU.
> 
> It may be checked by disabling ACPI (if enabled) and/or monitoring
> /proc/acpi/thermal_zone/THRM/temperature (if any).

Happens on a system without ACPI or Power Management of any kind enabled 
though.

Brad
