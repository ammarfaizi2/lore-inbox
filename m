Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUIJQtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUIJQtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUIJQt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:49:28 -0400
Received: from ozlabs.org ([203.10.76.45]:17881 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267583AbUIJQs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:48:27 -0400
Date: Sat, 11 Sep 2004 02:44:25 +1000
From: Anton Blanchard <anton@samba.org>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Nathan Bryant <nbryant@optonline.net>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Latest microcode data from Intel.
Message-ID: <20040910164425.GS24408@krispykreme>
References: <4141CCA8.30807@optonline.net> <Pine.LNX.4.44.0409101650130.1294-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409101650130.1294-100000@einstein.homenet>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> CPU hotplug? Is there such a thing as _working_ CPU hotplug support in 
> Linux? (or any hardware that can actually allow unplugging/plugging CPUs?)

Sure, on ppc64 we move CPUs between partitions on the fly and use
hotplug cpu tricks with POWER5 threads to switch between single
threaded mode and SMT mode while the OS is running.

Anton
