Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270498AbTGXGFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 02:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270503AbTGXGFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 02:05:11 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:56247
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S270498AbTGXGFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 02:05:07 -0400
Message-ID: <3F1F7A97.7000304@candelatech.com>
Date: Wed, 23 Jul 2003 23:20:07 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Wood <eric@interplas.com>
CC: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: RH 9 kernel compile error
References: <077a01c35157$d898c100$9100000a@intgrp.com>
In-Reply-To: <077a01c35157$d898c100$9100000a@intgrp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Wood wrote:
> Sorry for the newbie question.
> I'm trying some new megaraid drivers so I have to recompile.  For RH9, in
> the /usr/src/linux-2.4/ directory, I used:
> 
> # cp configs/kernel-2.4.20-i686.config .config
> # make rpm
> 
> During the recompile I get an error:
> I have 2.4.20-18.9 and 2.4.20-6 installed and get the error for both
> versions. Any ideas?
> -eric wood

Try doing a make mrproper or make clean first.  That has helped
me compile redhat kernels.  After mrproper, have to copy the .config
again, make menuconfig (or maybe oldconfig would work),
then: make dep bzImage modules

I have never used rpm target...but I imagine it works :)

Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


