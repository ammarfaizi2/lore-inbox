Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbTFLBOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264678AbTFLBOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:14:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48120 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264677AbTFLBO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:14:27 -0400
Subject: Re: [patch] as-iosched divide by zero fix
From: Robert Love <rml@tech9.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@digeo.com>, bos@serpentine.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <3EE7D5F2.1070508@cyberone.com.au>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	 <20030611154122.55570de0.akpm@digeo.com> <1055374476.673.1.camel@localhost>
	 <1055377120.665.6.camel@localhost> <20030611172444.76556d5d.akpm@digeo.com>
	 <1055380257.662.8.camel@localhost> <3EE7D5F2.1070508@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1055381384.662.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 11 Jun 2003 18:29:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 18:22, Nick Piggin wrote:

> It would occur if a write batch didn't take any jiffies, which
> isn't very likely. The HZ=100 change probbly brought it out.

I reverted that change (yah yah, I am no help). I have seen the problem
since mm6, but just today got around to looking into it.

Anyhow, its fixed.

	Robert Love

