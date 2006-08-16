Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWHPWet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWHPWet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWHPWet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:34:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27304 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932288AbWHPWes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:34:48 -0400
Date: Wed, 16 Aug 2006 15:34:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
In-Reply-To: <44E344A8.1040804@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0608161533580.19172@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <44E344A8.1040804@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Manfred Spraul wrote:

> Which .config settings are necessary? I tried to use it (uniprocessor, no
> debug options enabled), but the compilation failed. 2.6.18-rc4 kernel. All 7
> patches applied.

Ahh. Tried it on i386. This works if you disable full slab support.
