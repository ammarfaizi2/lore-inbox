Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263603AbUEXTba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUEXTba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 15:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUEXTb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 15:31:26 -0400
Received: from zero.aec.at ([193.170.194.10]:33029 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263603AbUEXTbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 15:31:25 -0400
To: MalteSch@gmx.de
cc: linux-kernel@vger.kernel.org
Subject: Re: Bad X-performance on 2.6.6 & 2.6.7-rc1 on x86-64
References: <1ZqbC-5Gl-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 24 May 2004 21:31:21 +0200
In-Reply-To: <1ZqbC-5Gl-13@gated-at.bofh.it> (Malte
 =?iso-8859-1?Q?Schr=F6der's?= message of "Mon, 24 May 2004 18:10:08 +0200")
Message-ID: <m3r7t9d3li.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Malte Schröder <MalteSch@gmx.de> writes:

> Hi,
> I build a 64-bit kernel (using gcc 3.3.3) on debian/sid for an Athlon 64 3200+. The System has a Radeon 9800pro as graphics card. 
> When playing videos using xine in full PAL-Resolution these videos run choppy, top then shows a cpuload of roughly 50% system and 50% user.

I would suggest using oprofile to find out where the CPU time is going.

2.6.7rc1 had a fix to help performance with hardware accelerated
DVD playback on x86-64, but apparently that's not what you're doing.

-Andi

