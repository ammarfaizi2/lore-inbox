Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272215AbTHDUE6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272221AbTHDUEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:04:43 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:23989 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S272215AbTHDUCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:02:52 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Werner Almesberger <werner@almesberger.net>
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 4 Aug 2003 13:01:02 -0700 (PDT)
Subject: Re: TOE brain dump
In-Reply-To: <20030804165649.N5798@almesberger.net>
Message-ID: <Pine.LNX.4.44.0308041259220.7534-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003, Werner Almesberger wrote:

> David Lang wrote:
> > also how many of the standard kernel features could you turn off?
>
> You don't turn them off - you just don't run them. What I'm
> suggesting is not a separate system that runs a stripped-down
> Linux kernel, but rather a device that looks like another
> node in a NUMA system.
>
> There might be a point in completely excluding subsystems
> that will never be used on that NIC anyway, but that's already
> an optimization.

I would think that it's much more difficult to run NUMA across different
types of CPU's then it would be to run a seperate kernel on the NIC.

I'm thinking clustering instead of single-system-image.

David Lang
