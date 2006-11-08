Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754277AbWKHFOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbWKHFOJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754278AbWKHFOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:14:09 -0500
Received: from hierophant.serpentine.com ([64.81.58.173]:63161 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1754281AbWKHFOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:14:06 -0500
Message-ID: <4551679D.9010604@serpentine.com>
Date: Tue, 07 Nov 2006 21:14:05 -0800
From: "Bryan O'Sullivan" <bos@serpentine.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       olson@pathscale.com, akpm@osdl.org
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>	<20061105064801.GV13381@stusta.de>	<m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>	<20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>	<m1psbzbpxw.fsf@ebiederm.dsl.xmission.com>	<4550B22C.1060307@serpentine.com>	<m18xinb1qn.fsf@ebiederm.dsl.xmission.com>	<4550FB5D.5010804@serpentine.com> <m18xim9atv.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18xim9atv.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> Ok.  It looks good except you aren't calling ht_destroy_irq on driver unload.
> Which is a small resource leak.

Yeah, I'm also not reprogramming that register if the interrupt routing 
changes.  Ran out of time today.  I'll fix those tomorrow.

	<b
