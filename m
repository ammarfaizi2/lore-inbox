Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267628AbUBTBHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUBTBGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:06:51 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:22913 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267353AbUBTBG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:06:26 -0500
Date: Thu, 19 Feb 2004 20:06:23 -0500
From: Tom Vier <tmv@comcast.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Deadlocks and Machine Check Exception on Athlon64
Message-ID: <20040220010623.GA14838@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <1077229909.2828.22.camel@terminal124.gozu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077229909.2828.22.camel@terminal124.gozu.lan>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 11:31:50PM +0100, Ronny V. Vindenes wrote:
> CPU 0: Machine Check Exception : 0000000000000004
> Bank 4: b200000000070f0f
> kernel panic: CPU context corrupt
> In interrupt handler - not syncing

i've gotten the same machine check a couple times. it only happened the
first few days i had my machine. i updated to the latest tyan bios which
fixes some bugs. i haven't had it happen since.

if i'm reading it right (which is hard on this small screen, slow cpu
laptop), page 153 of the opteron kernel/bios guide says this is an ecc data
cache exception (which is always fatal/nonrecoverable). this sounds like
errata 86, which is fixed in the tyan bios update i installed.

does msi say their 2.1 bios fixes #86?

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
