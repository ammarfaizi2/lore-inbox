Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVAJTsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVAJTsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVAJTrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:47:42 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:3533 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262286AbVAJTcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:32:21 -0500
Subject: Re: starting with 2.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@gmail.com>
Cc: John Richard Moser <nigelenki@comcast.net>, znmeb@cesmail.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e99705010917281c6634b8@mail.gmail.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <41DD9968.7070004@comcast.net>
	 <1105045853.17176.273.camel@localhost.localdomain>
	 <1105115671.12371.38.camel@DreamGate> <41DEC5F1.9070205@comcast.net>
	 <1105237910.11255.92.camel@DreamGate> <41E0A032.5050106@comcast.net>
	 <1105278618.12054.37.camel@localhost.localdomain>
	 <41E1CCB7.4030302@comcast.net>  <21d7e99705010917281c6634b8@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105361337.12054.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 Jan 2005 18:27:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 01:28, Dave Airlie wrote:
> I do wonder would open source kernel drivers to work with a closed
> source user space application be accepted into the mainline kernel...
> say for example Nvidia or VMware GPL'ed their lower layer kernel

It isnt about whether they are "accepted" but whether they are
derivative works. The license is quite clear on this with the specific
clarification included for the syscall interface. For the most part the
interfaces people need are pretty generic so the problems don't arise.

We've seen that with the proposed 1Gb DMA area on x86-64 - Nvidia wanted
a 4Gb one to fix their hardware needs and various other drivers want a
1Gb DMA area. That happens to also sort Nvidia's problems.

>From DRI experience I'd say that a mostly user space nvidia driver would
probably be almost as problematic as a binary kernel module. It would
make reverse engineering a lot easier though 8)

