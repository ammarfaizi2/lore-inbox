Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268420AbUI3AcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268420AbUI3AcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 20:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUI3AcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 20:32:21 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:53642 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268420AbUI3AcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 20:32:20 -0400
Message-ID: <e2ae0e3b04092917327cd3225f@mail.gmail.com>
Date: Wed, 29 Sep 2004 20:32:19 -0400
From: white phoenix <white.phoenix@gmail.com>
Reply-To: white phoenix <white.phoenix@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: nforce2 bugs?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096496263.16768.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <e2ae0e3b04092915427fcff604@mail.gmail.com>
	 <1096496263.16768.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

would be nice to have some of these in the mainstream kernel, if they
are legit bugs. i see one of those patches fixes the timer. nforce2
timer isn't connected to pin0 so it falls back to XT-PIC unless i add
"acpi_skip_timer_override" to the kernel perameters.
2.6.8.1 oops's on me very rarely with something about irq not syncing,
which may be related to some of these nforce2 quirks. 2.6.9 is just a
mess, always freezes on me.
