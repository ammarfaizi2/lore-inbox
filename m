Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTFLRGD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbTFLRGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:06:03 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:44470 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S264902AbTFLRF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:05:58 -0400
Subject: Re: 2.5.70-mm8: freeze after starting X
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au
In-Reply-To: <20030611172444.76556d5d.akpm@digeo.com>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	 <20030611154122.55570de0.akpm@digeo.com> <1055374476.673.1.camel@localhost>
	 <1055377120.665.6.camel@localhost> <20030611172444.76556d5d.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1055438377.1058.2.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 10:19:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 17:24, Andrew Morton wrote:

> Odd that starting the X server triggers it.  Be interesting if your patch
> fixes things for Brian.

I think Robert and I are seeing different things.  For me, -mm6 is fine
(unlike Robert's case), -mm7 oopses in the PCI init code during early
boot (somewhere in the radeon init stuff, can't capture the oops
easily), and -mm8 gives itself a wedgie a few seconds after starting X.

I'm about to try, um, whichever of the umpty-ump patches that went back
and forth looks most plausible.

	<b

