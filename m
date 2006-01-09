Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWAIR57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWAIR57 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWAIR57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:57:59 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:24764 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030223AbWAIR56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:57:58 -0500
Date: Mon, 9 Jan 2006 09:57:29 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-git: BITS_PER_LONG
In-Reply-To: <20060107144940.GE31384@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0601090956340.2202@schroedinger.engr.sgi.com>
References: <20060107144940.GE31384@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2006, Russell King wrote:

> Hi.
> 
> With the latest git, I'm seeing a number of:
> 
> include/asm-generic/atomic.h:20:5: warning: "BITS_PER_LONG" is not defined
> 
> What's intended here?  Should asm-generic/atomic.h include asm/types.h?

asm/types.h should be included by asm/atomic.h. Which arch is this?

