Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTILEuc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 00:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTILEuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 00:50:32 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:33295
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261678AbTILEu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 00:50:26 -0400
Subject: Re: [RFC] Enabling other oom schemes
From: Robert Love <rml@tech9.net>
To: rusty@linux.co.intel.com
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <200309120219.h8C2JANc004514@penguin.co.intel.com>
References: <200309120219.h8C2JANc004514@penguin.co.intel.com>
Content-Type: text/plain
Message-Id: <1063342229.700.240.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 00:50:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-11 at 22:19, Rusty Lynch wrote:

> The patch works (although by looking over oom_kill.c, I'm sure oom_panic.c
> will panic too soon), but it is really only a quick hack to see how people
> feel about such an approach.

I like this a _lot_, it is something I have thought about doing, and
something we have a need for at MontaVista.

But I think its a lot more useful if we have alternative overcommit
modes to use with it.

An oom_nop might be a good idea.  But some different policies, i.e. ones
with more determinism but less smarts, are interesting.

	Robert Love


