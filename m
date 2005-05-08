Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVEHNEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVEHNEU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 09:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbVEHNET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 09:04:19 -0400
Received: from sd291.sivit.org ([194.146.225.122]:32526 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261504AbVEHNEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 09:04:16 -0400
Date: Sun, 8 May 2005 15:04:13 +0200
From: Stelian Pop <stelian@popies.net>
To: Gustav Petersson <gustav.petersson@karlskrona.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: powernow-k8 in 2.6.8 - 2.6.11.8 causes system hang
Message-ID: <20050508130407.GA17407@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Gustav Petersson <gustav.petersson@karlskrona.net>,
	linux-kernel@vger.kernel.org
References: <1115475314.4985.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115475314.4985.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 04:15:14PM +0200, Gustav Petersson wrote:

> Hello all, I haven't found any reports on this issue anywhere so I'm
> starting to think it's a motherboard or BIOS issue but I figure I should
> report it anyway.
> 
> I have an Asus K8N-E Deluxe (socket 754) with an Athlon64 3000+. I've
> tried with different BIOS versions, from 1005 to 1007-beta without
> success. 

I also have this exact combination of motherboard and cpu and I experience
the same problems: when the processor is in "performance" mode, the
system works perfectly (I have 3 months+ uptime on it). As soon as
I lower the speed (either manually, or automaticaly using some kernel
or userspace daemon), random processes get killed (X, gcc etc with
signal 11), and sooner or later the system hangs.

Since this is my main workstation (and I don't really need cpufreq)
I haven't done much testing. I also mainly run RedHat (FC3) kernels
on this box.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
