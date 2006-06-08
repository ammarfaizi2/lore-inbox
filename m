Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWFHNU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWFHNU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 09:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWFHNU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 09:20:28 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:50903
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751326AbWFHNU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 09:20:27 -0400
Message-ID: <44882408.3060303@microgate.com>
Date: Thu, 08 Jun 2006 08:20:08 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jeff@garzik.org, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
References: <1149694978.12920.14.camel@amdx2.microgate.com>	<20060607230202.GA12210@havoc.gtf.org>	<44876D59.1000509@microgate.com>	<44877659.2020103@microgate.com> <20060607182808.a230e5ee.akpm@osdl.org>
In-Reply-To: <20060607182808.a230e5ee.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Well your patch looked reasonable, except it muddies the CONFIG_foo
> namespace.

I had misinterpreted Jeff's post as saying defining
macros based on kernel configuration for conditional
compilation was not allowed.

With Andrew's technical explanation that altering
the CONFIG_X namespace in code is the problem,
the cleanest solution is to combine Randy's last patch
with fix-kbuild-dependencies-for-synclink-drivers.patch

I'll combine those two against 2.6.7-rc6-mm1

-- 
Paul Fulghum
Microgate Systems, Ltd.
