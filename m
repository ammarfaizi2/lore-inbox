Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTFKVX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTFKVX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:23:27 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:57729
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264372AbTFKVXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:23:15 -0400
Date: Wed, 11 Jun 2003 17:25:40 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Artemio <artemio@artemio.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP question
In-Reply-To: <200306112252.40979.artemio@artemio.net>
Message-ID: <Pine.LNX.4.50.0306111721220.19137-100000@montezuma.mastecende.com>
References: <200306112043.11923.artemio@artemio.net> <3EE7852C.2050605@rackable.com>
 <200306112252.40979.artemio@artemio.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jun 2003, Artemio wrote:

> I'm building a hard real-time Linux (RTLinux) system on a 2x Xeon machine. If 
> I compile and run a 2.4.18 kernel with SMP support, rtlinux hangs the 
> machine. However, with SMP disabled, rtlinux and all it's hard-realtime 
> applications runs okay.

Sounds like an RTLinux bug, perhaps you should elaborate on that on the 
RTLinux mailing list.

> So, I have to deside between these two:
> 
>  - Run rtlinux and hard-realtime applications on a kernel without SMP support. 
> How much performance will I loose this way? Is SMP *THAT* critical? 

Depending on your load it could make a very significant difference.

>  - Run all tasks in a usual way, no hard realtime, but with SMP support.

If you have that option you didn't need hard realtime in the first place.

> Also, if I turn hyperthreading off, how will it influence the system with SMP 
> support? Without SMP support?

HT w/ SMP = You'll have to do your own tests with your applications
HT w/o SMP = Normal UP

	Zwane
-- 
function.linuxpower.ca
