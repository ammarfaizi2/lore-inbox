Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbUCZPpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 10:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264065AbUCZPpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 10:45:11 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:28062 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264062AbUCZPpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 10:45:05 -0500
Message-ID: <40644FCA.8000206@pacbell.net>
Date: Fri, 26 Mar 2004 07:44:10 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Robert Schwebel <robert@schwebel.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
References: <20040325221145.GJ10711@pengutronix.de>	 <40636295.7000008@pacbell.net> <1080297466.29835.144.camel@hades.cambridge.redhat.com>
In-Reply-To: <1080297466.29835.144.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> Out of interest -- have they (or has anyone else) invented a 'file
> system' USB device yet? For exporting some file systems, pretending to
> be a block device really isn't very useful.

There's a file system protocol used by many digital still cameras,
which isn't actually camera-specific.  Not MSFT-specific either.

Originally called "Picture Transfer Protocol" (PTP) it's actually
more of a remote hierarchical filesystem protocol ... with an event
channel (handy for "new picture" or "inserted new flash memory")
and some built-in search capabilities ("what JPGs do you have").
The strangest capability was a file type tag, which isn't actually
that bizarre.

As with RNDIS, and USB Mass Storage, I understand that support for
PTP is part of MS-Windows since about Win2K.  So a PTP gadget
driver would probably be a useful contribution to Linux.

- Dave



