Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVEGSOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVEGSOf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 14:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVEGSOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 14:14:30 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:3082 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262737AbVEGSO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 14:14:26 -0400
Date: Sat, 7 May 2005 20:05:20 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050507180520.GB19380@alpha.home.local>
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net> <20050506211455.3d2b3f29.akpm@osdl.org> <20050507075828.GF777@alpha.home.local> <427D00E8.4070208@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427D00E8.4070208@stesmi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 07:54:48PM +0200, Stefan Smietanowski wrote:
 
> When one defines it one way you can be sure there'll come some company
> and figure something out that doesn't fit into that representation.
> 
> Like - Stick a board into the CPU slot of some motherboard. That board
> has two DualCore, SMT chips.
> 
> Oops.
> 
> Now the funny part - there is a company selling those things (not
> dualcore yet, but SMT anyhow).
>
> How do you fit it into that model?

Two CPU on a board accessing the memory through a same bus is just like
a NUMA node. Anyway, as Dave told it, it's even better to have the kernel
translate the application needs into hardware ressources as it is the
best one to deal with those hardware builders' fantasies.

Regards,
Willy

