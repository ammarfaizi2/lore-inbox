Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTKVQUv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 11:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTKVQUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 11:20:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:25578 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262395AbTKVQUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 11:20:50 -0500
Date: Sat, 22 Nov 2003 08:20:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: SVR Anand <anand@eis.iisc.ernet.in>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: 2.6.0-test9 : bridge freezes
In-Reply-To: <200311221527.UAA29684@eis.iisc.ernet.in>
Message-ID: <Pine.LNX.4.44.0311220819260.2379-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Nov 2003, SVR Anand wrote:
> 
> The problem is : After 3 to 4 hours of functioning, the bridge stops working 
> and the machine becomes unusable where it doesn't respond to keyboard, and 
> there is no video display.

Sounds like a memory leak somewhere. It would probably be interesting to 
watch /proc/slabinfo every five minutes or so, and see what happens..

		Linus

