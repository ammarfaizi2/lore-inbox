Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTIKCUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 22:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbTIKCUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 22:20:47 -0400
Received: from holomorphy.com ([66.224.33.161]:19894 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262680AbTIKCUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 22:20:46 -0400
Date: Wed, 10 Sep 2003 19:21:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Maciej <maciej@apathy.killer-robot.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] i386 /proc/irq/.../smp_affinity
Message-ID: <20030911022154.GR4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Maciej <maciej@apathy.killer-robot.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030910191459.GA12099@apathy.black-flower> <Pine.LNX.4.53.0309101535050.9323@montezuma.fsmlabs.com> <20030911020218.GQ4306@holomorphy.com> <Pine.LNX.4.53.0309102206300.5403@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309102206300.5403@montezuma.fsmlabs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, William Lee Irwin III wrote:
>> This backs out the variable-length cpu bitmask handling.
>> I appear to be printing out 16-bit chunks of all this in what appears
>> to be the reverse of the order expected. Why not just reverse the order
>> of the 16-bit chunks?

On Wed, Sep 10, 2003 at 10:07:58PM -0400, Zwane Mwaikambo wrote:
> Indeed it does, i was thinking about supported systems and the lack of 
> NR_CPUS > BITS_PER_LONG ia32 boxen.

I'm sitting on one, I just don't have the power to configure it that way
on any kind of regular basis. I'm going to bet the input version has
this issue also.


-- wli
