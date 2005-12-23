Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbVLWCuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbVLWCuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 21:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbVLWCuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 21:50:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18917 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030384AbVLWCuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 21:50:05 -0500
Date: Thu, 22 Dec 2005 21:49:43 -0500
From: Dave Jones <davej@redhat.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH] Add memcpy32 function
Message-ID: <20051223024943.GC27537@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bryan O'Sullivan <bos@pathscale.com>, linux-kernel@vger.kernel.org,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>
References: <1135301759.4212.76.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135301759.4212.76.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 05:35:59PM -0800, Bryan O'Sullivan wrote:
 > In response to the comments that followed Roland Dreier posting our
 > InfiniPath driver for review last week, we've been making some cleanups
 > to our driver code.
 > 
 > As our chip requires 32-bit accesses, we need a copy function that
 > guarantees operating in such terms.  It was suggested that we make this
 > generic, with arch-specific optimised versions.
 > 
 > This patch introduces the generic copy routine, memcpy32.  At Andrew's
 > suggestion, I've put it in a new header file, include/linux/io.h, which
 > I've styled after include/linux/string.h.

io.h is a very generic sounding name for something that just houses
a memcpy variant.  What's wrong with calling a spade a spade,
and using memcpy32.h ?

		Dave

