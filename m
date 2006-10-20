Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992682AbWJTSwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992682AbWJTSwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992705AbWJTSwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:52:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27067 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992682AbWJTSwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:52:50 -0400
Date: Fri, 20 Oct 2006 11:52:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] statistics: fix buffer overflow in histogram with
 linear scale
Message-Id: <20061020115242.ff4acce2.akpm@osdl.org>
In-Reply-To: <1161352724.3135.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1161352724.3135.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 15:58:44 +0200
Martin Peschke <mp3@de.ibm.com> wrote:

> --- a/lib/statistic.c	2006-10-08 23:03:56.000000000 +0200
> +++ b/lib/statistic.c	2006-10-12 19:38:08.000000000 +0200

So...  what are we going to do with the statistics stuff?  It needs users
to prove its desirability/suitability.  I think there was some work done in
the SCSI area - did that come to anything?
