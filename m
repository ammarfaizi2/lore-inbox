Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264663AbUEOH4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264663AbUEOH4y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 03:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUEOH4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 03:56:54 -0400
Received: from science.horizon.com ([192.35.100.1]:10280 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S264663AbUEOH4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 03:56:53 -0400
Date: 15 May 2004 07:56:52 -0000
Message-ID: <20040515075652.1915.qmail@science.horizon.com>
From: linux@horizon.com
To: akpm@osdl.org
Subject: Re: 2.6.6 is crashing repeatedly
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040514232842.63fd3240.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you enable CONFIG_SLAB_DEBUG?  And CONFIG_DEBUG_PAGEALLOC too, although
> beware that the latter is a bit costly in terms of CPU cycles and memory
> usage.

Just rebooted with
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_PAGEALLOC=y

More news when something happens.

Thanks for your instant diagnosis!
