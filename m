Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTKHRxE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 12:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTKHRxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 12:53:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:59018 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261914AbTKHRxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 12:53:02 -0500
Date: Sat, 8 Nov 2003 09:52:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ragnar Hojland Espinosa <ragnar@linalco.com>
cc: Bill Davidsen <davidsen@tmr.com>, John Bradford <john@grabjohn.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <20031108150654.GA19980@linalco.com>
Message-ID: <Pine.LNX.4.44.0311080950520.2787-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Nov 2003, Ragnar Hojland Espinosa wrote:
> 
> Well, I hope its in better state than the Mitsumi driver, because last
> time I tried it was broken (oopsed in a simple cat) since a 2.3.xx
> IIRC [0]

Since 2._3_.xx?

> [0]  Tracked it down to a -pre if anyone is interested and its still
>      broken.. 

Quite frankly, if it's literally been broken since 2.3.x, I think the best 
thing to do would be to remove the driver entirely.

Yeah, there's probably a fair number of those old CD-ROM drivers that 
nobody uses with modern kernels (ie they might be used on some router that 
hasn't been touched in forever, still running 2.2.x on a 8MB 386SX-16).

		Linus

