Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269033AbTCAVYe>; Sat, 1 Mar 2003 16:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269034AbTCAVYe>; Sat, 1 Mar 2003 16:24:34 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:40103 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269033AbTCAVYe>;
	Sat, 1 Mar 2003 16:24:34 -0500
Message-ID: <3E612728.6040707@us.ibm.com>
Date: Sat, 01 Mar 2003 13:33:28 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Dave Jones <davej@codemonkey.org.uk>, Anton Blanchard <anton@samba.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, cliffw@osdl.org, akpm@zip.com.au,
       slpratt@austin.ibm.com, levon@movementarian.org
Subject: Re: [PATCH] documentation for basic guide to profiling
References: <8550000.1046419962@[10.10.2.4]> <20030228002935.256ffa98.akpm@digeo.com> <20030228112238.GJ4911@codemonkey.org.uk> <20030228152838.GB32449@gtf.org> <20010101052723.GB22212@krispykreme> <447430000.1046473881@flay> <20030301175114.GA30911@codemonkey.org.uk> <3200000.1046552148@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>--start implies starting the daemon if it isn't started
>>already.
> 
> I think John suggested to do those seperately, to minimise overhead
> or something.

On a heavily loaded system, --start can take quite a while if the daemon
isn't already running.  Before starting my machine-killing benchmark
(which I want to profile), I use --start-daemon which gets most of the
work out of the way.  The subsequent --start, which occurs while the
benchmark is already steaming along, will happen quickly and with much
less impact to the benchmark results.

-- 
Dave Hansen
haveblue@us.ibm.com

