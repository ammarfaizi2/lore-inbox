Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUCOFvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUCOFvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:51:04 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:25798 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262272AbUCOFvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:51:02 -0500
Date: Mon, 15 Mar 2004 00:51:02 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nishant Nagalia <ninagal@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interrupts
In-Reply-To: <Pine.GSO.4.53.0403142216500.18610@compserv2>
Message-ID: <Pine.LNX.4.58.0403150041460.28447@montezuma.fsmlabs.com>
References: <Pine.GSO.4.53.0403142216500.18610@compserv2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2004, Nishant Nagalia wrote:

> Hello,
>
> I am trying to modify linux scheduler for my project.
>
> I want to schedule interrupts whenever I want,means I want to queue
> an interrupt when it comes and execute it when my scheduler will want it
> to. I should be able to queue it before it executes any function/ISR
> inside kernel and then schedule it when required.
>
> I am not able to find proper documentation of how exactly I can do this. I
> would really appreciate if anyone can help me in this regards.

There isn't any documentation stating how to do that because Linux doesn't
use that interrupt handling model. Perhaps you should be looking at the
FreeBSD 5 interrupt thread code instead.
