Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWIGAGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWIGAGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 20:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWIGAGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 20:06:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19645 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030268AbWIGAGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 20:06:12 -0400
Date: Thu, 7 Sep 2006 02:05:59 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
In-Reply-To: <20060906235029.GC25473@stusta.de>
Message-ID: <Pine.LNX.4.64.0609070202040.6761@scrub.home>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de>
 <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de>
 <Pine.LNX.4.64.0609070115270.6761@scrub.home> <20060906235029.GC25473@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Sep 2006, Adrian Bunk wrote:

> it's correct, since with -ffreestanding gcc no longer has the right to 
> assume it had a full libc available.

BS, even without it gcc can't make such assumption.
There is not a single optimization, which would be invalid in a kernel 
environment and would be "fixed" by this option, so please stop this 
nonsense.

bye, Roman
