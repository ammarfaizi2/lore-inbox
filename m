Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUHHSXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUHHSXw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 14:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUHHSXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 14:23:52 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:50922 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266136AbUHHSXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 14:23:11 -0400
Date: Sun, 8 Aug 2004 14:27:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH][2.6] fix i386 idle routine selection
In-Reply-To: <Pine.LNX.4.58.0408081403460.19619@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0408081426380.19619@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408081403460.19619@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2004, Zwane Mwaikambo wrote:

> This was broken when the mwait stuff went in since it executes after the
> initial idle_setup() has already selected an idle routine and overrides it
> with default_idle.

That subject should really read i386/x86_64 of course.

