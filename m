Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264215AbUFRAW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUFRAW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUFRAW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:22:26 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:17899 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264843AbUFRAWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:22:17 -0400
Date: Thu, 17 Jun 2004 17:21:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
Message-ID: <3217460000.1087518092@flay>
In-Reply-To: <40D232AD.4020708@opensound.com>
References: <40D232AD.4020708@opensound.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am writing this message to bring a huge problem to light. SuSE has been systematically
> forking the linux kernel and shipping all kinds of modifications and still call their
> kernels 2.6.5 (for example).
> 
> Either they ship the stock Linux kernel sources or they stop calling their distributions
> as Linux-2.6.x based.

Umm. They said they're linux-2.6.x based ... ie they're BASED on 2.6,
not identical. No major vendor ships completely virgin source.
 
> Kernel headers are being changed willy-nilly and SuSE are completely running rough-shod
> over the linux kernel with the result ONLY software from SuSE works.

I think you're getting somewhat carried away. Yes, there are lots of mods.
Most of them are merged back into mainline already (as of 2.6.7).
 
> This is absolutely not our problem and we don't know who to contact at SuSE to fix
> this problem. Our software works perfectly with Fedora/Debian/Gentoo/Mandrake/Redhat/etc.

So what's broken then? Specifically which kernel interface are you 
calling that has a broken behaviour?

> I think SuSE's lying when they call their Linux kernel a 2.6.5 kernel 
> when there are massive differences. 

They didn't say it was 2.6.5, they said it was based on it.

> They aren't even compatible with Linux 2.6.6.

In what way?
 
> I urge all those who have the power to sway distributions to 
> immediately fix their kernels so that small developers like us don't 
> have to keep updating our software.

I'd be more inclined to suspect you're relying on some behaviour that isn't
really defined ...

And no, I don't work for SuSE.

M.

