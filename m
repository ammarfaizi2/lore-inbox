Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTK0PYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 10:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTK0PYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 10:24:18 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:3726 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S264539AbTK0PYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 10:24:07 -0500
Date: Thu, 27 Nov 2003 16:23:55 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Simon <simon@highlyillogical.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test10] cpufreq: 2G P4M won't go above 1.2G - cpuinfo_max_freq too low
Message-ID: <20031127152355.GA10338@localhost>
References: <200311271139.07260.simon@highlyillogical.org> <200311271323.37123.simon@highlyillogical.org> <20031127134245.GA9404@localhost> <200311271457.48812.simon@highlyillogical.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200311271457.48812.simon@highlyillogical.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 27th 2003 Simon wrote:

> You're a star, thankyou. It was loading p4-clockmod by default. I had all the 
> pentium-related modules compiled in, and it was behaving like that... dmesg 
> said it was loading p4-clockmod.
> 
> I modprobe'd speedstep-ich instead, and foom! Straight up to 2ghz.

Thanks to Linux and modules! I find that the detailed logging sent by
modules as they are loaded is generally very helpful.

When dealing with unknown or misbehaving hardware, be it soundcards, USB
gadgets, FireWire camcorders or whatever, compiling all relevant drivers
as modules and experimenting with modprobe often gives new insights and
with any luck you'll even find the setup that makes it work! ;-)
-- 
Marco Roeland
