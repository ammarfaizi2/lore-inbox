Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUA0EFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 23:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUA0EFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 23:05:20 -0500
Received: from adsl-80-199-41.jax.bellsouth.net ([65.80.199.41]:27700 "EHLO
	theorem093.dyndns.org") by vger.kernel.org with ESMTP
	id S261744AbUA0EFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 23:05:16 -0500
Date: Mon, 26 Jan 2004 23:06:40 -0500
From: Zack Winkles <winkie@linuxfromscratch.org>
To: Xan <DXpublica@telefonica.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] fbdev console: can't load vga=791 and yes vga=ask!
Message-ID: <20040127040640.GA31326@theorem093.dyndns.org>
Mail-Followup-To: Zack Winkles <winkie@linuxfromscratch.org>,
	Xan <DXpublica@telefonica.net>, linux-kernel@vger.kernel.org
References: <200401270153.12568.DXpublica@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401270153.12568.DXpublica@telefonica.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 01:53:12AM +0100, Xan wrote:
> I don't know if it's a bug of kernel, but I can't load 2.6.1 with vga=791 in 
> LILO but yes with vga=ask.
> 
> In the previous version (2.6.0), I remember that I got vga=791. But perhaps I 
> a personal error.

You didn't mention what driver you're using, but with vesafb simply
using the values from Documentation/fb/vesafb.txt works for me.  In my
case, I pass vga=0x317.

It seems that 2.6.x is a lot more sensitive to what you pass to vga=
than was the 2.4.x series...

