Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263703AbTKKTYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 14:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTKKTWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 14:22:51 -0500
Received: from dp.samba.org ([66.70.73.150]:45016 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263698AbTKKTWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 14:22:16 -0500
Date: Wed, 12 Nov 2003 06:19:25 +1100
From: Anton Blanchard <anton@samba.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
Message-ID: <20031111191924.GR930@krispykreme>
References: <Pine.SGI.4.53.0311111116440.360387@subway.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.53.0311111116440.360387@subway.americas.sgi.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On systems with lots of processors (512 for example), catting
> /proc/interrupts fails with a "not enough memory" error.

FYI we are seeing this on ppc64 too (less cpus but probably more
interrupt sources).

Anton
