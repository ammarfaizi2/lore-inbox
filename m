Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVAQEiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVAQEiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 23:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVAQEiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 23:38:09 -0500
Received: from fsmlabs.com ([168.103.115.128]:63456 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262679AbVAQEhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 23:37:18 -0500
Date: Sun, 16 Jan 2005 21:37:28 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, Linux PPC64 <linuxppc64-dev@ozlabs.org>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC64 pmac hotplug cpu
In-Reply-To: <1105827794.27410.82.camel@gaston>
Message-ID: <Pine.LNX.4.61.0501162129380.3010@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0501122341410.23299@montezuma.fsmlabs.com>
 <1105827794.27410.82.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ben,

On Sun, 16 Jan 2005, Benjamin Herrenschmidt wrote:

> Looks good, but you could do even better :) I still want to look at the
> proper mecanism to flush the CPU cache on 970, but the idea here is to
> flush it, and put the CPU into a NAP loop (the 970 has no SLEEP mode)
> with the caches clean and MSR:EE off. We can later get it back with a
> soft reset.

Thanks for the suggestions! I'll work on getting something together.

	Zwane

