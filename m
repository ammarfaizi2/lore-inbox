Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbSLMDPm>; Thu, 12 Dec 2002 22:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267584AbSLMDPm>; Thu, 12 Dec 2002 22:15:42 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:59093
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267512AbSLMDPh>; Thu, 12 Dec 2002 22:15:37 -0500
Date: Thu, 12 Dec 2002 22:26:05 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: jamesclv@us.ibm.com, Martin Bligh <mbligh@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
In-Reply-To: <F2DBA543B89AD51184B600508B68D40010F1CE54@fmsmsx103.fm.intel.com>
Message-ID: <Pine.LNX.4.50.0212122221450.6931-100000@montezuma.mastecende.com>
References: <F2DBA543B89AD51184B600508B68D40010F1CE54@fmsmsx103.fm.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, Nakajima, Jun wrote:

> BTW, we are working on a xAPIC patch that supports more than 8 CPUs in a
> generic fashion (don't use hardcode OEM checking). We already tested it on
> two OEM systems with 16 CPUs.
> - It uses clustered mode. We don't want to use physical mode because it does
> not support lowest priority delivery mode.

Wouldn't that only be for all including self? Or is the documentation
incorrect?

Thanks,
	Zwane
-- 
function.linuxpower.ca
