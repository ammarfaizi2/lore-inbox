Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264177AbTEOTHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTEOTHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:07:13 -0400
Received: from holomorphy.com ([66.224.33.161]:42448 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264177AbTEOTHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:07:05 -0400
Date: Thu, 15 May 2003 12:19:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       keith maanthey <kmannth@us.ibm.com>
Subject: Re: [PATCH] linux-2.5.69_subarch-fix_A0.patch
Message-ID: <20030515191919.GR8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	keith maanthey <kmannth@us.ibm.com>
References: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com> <20030515065120.GA3469@Wotan.suse.de> <1053019259.9630.91.camel@w-jstultz2.beaverton.ibm.com> <20030515172855.GA10831@Wotan.suse.de> <1053020763.9629.104.camel@w-jstultz2.beaverton.ibm.com> <20030515190006.GA30173@Wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515190006.GA30173@Wotan.suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 10:46:03AM -0700, john stultz wrote:
>> I'd agree (long term even more strongly), although along with that I'd
>> like to be able to pick and choose my subarch. So I can have a kernel
>> that supports say, PC and BigSMP, but not NUMAQ or whatever. I believe
>> this is doable with your infrastructure, but I'm not sure how much work
>> it will take. 

On Thu, May 15, 2003 at 09:00:06PM +0200, Andi Kleen wrote:
> NUMAQ is not supported by the generic subarchitecture anyways.
> The only supported architecturs by generic are pc, bigsmp, summit.
> In theory you could subselect them, but it's only a few bytes for each
> so it's probably not worth the effort. Technically it isn't a big issue,
> you would just need to add it to Kconfig (not sure how to do that cleanly), 
> the Makefile and the probe table.

Okay, will fix.


-- wli
