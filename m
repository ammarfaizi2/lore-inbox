Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUCBAWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 19:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbUCBAWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 19:22:16 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:30992 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261518AbUCBAWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 19:22:15 -0500
Date: Tue, 2 Mar 2004 00:22:08 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: arief# <arief_m_utama@telkomsel.co.id>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
In-Reply-To: <1077932239.23405.71.camel@gaston>
Message-ID: <Pine.LNX.4.44.0403020019340.7718-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In fact, we should certainly fix fb_set_var to _ignore_ the activate
> field when comparing the var structures... this is a bug in the
> current version imho.
> 
> It's a bit difficult to fix it while keeping memcmp, except if we do
> a local copy of the var structure, which would eat stack space...

Yeah its a old bug. I don't know of a clean way to do that.
 

