Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbTISTex (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbTISTex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:34:53 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:31107
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261698AbTISTew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:34:52 -0400
Date: Fri, 19 Sep 2003 15:34:46 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: irq 11: nobody cared! is back
In-Reply-To: <20030919110749.7d24e1d4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0309191533390.29744@montezuma.fsmlabs.com>
References: <3F6B0671.1070603@jtholmes.com> <Pine.LNX.4.53.0309190951340.29744@montezuma.fsmlabs.com>
 <20030919110749.7d24e1d4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Sep 2003, Andrew Morton wrote:

> > boot with the 'noirqdebug' kernel parameter
> 
> That'll probably just make the box lock up.
> 
> Something seems to have gone wrong with uhci-hcd, failing to clear an
> interrupt source perhaps.

Indeed it did lockup his box (very nice, narrowed down the cause of the 
problem).
