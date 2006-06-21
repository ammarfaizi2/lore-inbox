Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWFULP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWFULP0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWFULP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:15:26 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:21915 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751503AbWFULPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:15:25 -0400
Date: Wed, 21 Jun 2006 07:15:07 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: art@usfltd.com
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.17-rt1-64bit-SMP compilation errors - mm/slab.c:...
In-Reply-To: <20060621033119.jxslshpug3k0kogc@69.222.0.225>
Message-ID: <Pine.LNX.4.58.0606210712430.31135@gandalf.stny.rr.com>
References: <20060621033119.jxslshpug3k0kogc@69.222.0.225>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jun 2006 art@usfltd.com wrote:

> 2.6.17-rt1-64bit-SMP compilation errors - mm/slab.c:3246: error: too
> few arguments to function ?__drain_alien_cache?
>

Ingo,

Looks like NUMA is broken again in 2.6.17-rt1.

art,

disable CONFIG_NUMA (for now) if you want to get it compiled.

-- Steve

