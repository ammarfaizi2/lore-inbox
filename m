Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUDCXvO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 18:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUDCXvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 18:51:14 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:27846 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262062AbUDCXvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 18:51:13 -0500
Date: Sat, 3 Apr 2004 18:51:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more i386 head.S cleanups
In-Reply-To: <406F3F2D.20301@quark.didntduck.org>
Message-ID: <Pine.LNX.4.58.0404031850460.16677@montezuma.fsmlabs.com>
References: <406ECAE7.1020407@quark.didntduck.org> <20040403160226.GY6248@waste.org>
 <406F3F2D.20301@quark.didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004, Brian Gerst wrote:

> > On a related note, I've been sitting on this patch which reorders the
> > bootstrap code so we can free most of it once we're up:
> >
>
> The bootstrap page tables can easily be reclaimed if large pages are
> used, but the bootstrap code needs more care, especially with hotplug cpus.

This would be fine for hotplug cpus as well, we never hit that path again.

