Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753830AbWKFVb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbWKFVb3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753834AbWKFVb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:31:28 -0500
Received: from iabervon.org ([66.92.72.58]:34834 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1753830AbWKFVb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:31:28 -0500
Date: Mon, 6 Nov 2006 16:31:26 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Dmitry Bohush <dmitrij.bogush@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: High pitch noise on Acer Aspire 5602WLMi
In-Reply-To: <2ac89c700611042257p6c4ea9cdsdfb7b2d3f2415d8a@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611061626500.9789@iabervon.org>
References: <2ac89c700611042257p6c4ea9cdsdfb7b2d3f2415d8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2006, Dmitry Bohush wrote:

> Hello,  Probably it is one of resistors on motherboard. This noise
> goes away with adding acpi=off to boot params.
> 
> What is this? It can be fixed?

Try processor.max_cstate=3; if that doesn't work, try =2. Google for 
max_cstate will give you tons of anecdotes.

	-Daniel
*This .sig left intentionally blank*
