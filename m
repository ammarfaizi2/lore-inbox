Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271694AbTHDT4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 15:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272169AbTHDT4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 15:56:55 -0400
Received: from almesberger.net ([63.105.73.239]:29445 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S271694AbTHDT4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 15:56:54 -0400
Date: Mon, 4 Aug 2003 16:56:49 -0300
From: Werner Almesberger <werner@almesberger.net>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
Message-ID: <20030804165649.N5798@almesberger.net>
References: <20030804163256.M5798@almesberger.net> <Pine.LNX.4.44.0308041243500.7534-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308041243500.7534-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Mon, Aug 04, 2003 at 12:48:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> also how many of the standard kernel features could you turn off?

You don't turn them off - you just don't run them. What I'm
suggesting is not a separate system that runs a stripped-down
Linux kernel, but rather a device that looks like another
node in a NUMA system.

There might be a point in completely excluding subsystems
that will never be used on that NIC anyway, but that's already
an optimization.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
