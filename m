Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270324AbTHBVBs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270346AbTHBVBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 17:01:47 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:62866 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270324AbTHBVBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 17:01:46 -0400
Subject: Re: TOE brain dump
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Werner Almesberger <werner@almesberger.net>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030802140444.E5798@almesberger.net>
References: <20030802140444.E5798@almesberger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059857864.20305.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Aug 2003 21:57:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-08-02 at 18:04, Werner Almesberger wrote:
>  - last but not least, keeping TOE firmware up to date with the
>    TCP/IP stack in the mainstream kernel will require - for each
>    such TOE device - a significant and continuous effort over a
>    long period of time

or even the protocol and protocol refinements..

>  - instead of putting a different stack on the TOE, a
>    general-purpose processor (probably with some enhancements,
>    and certainly with optimized data paths) is added to the NIC

Like say an opteron in the 2nd socket on the motherboard

> Benefits:
> 
>  - putting the CPU next to the NIC keeps data paths short, and
>    allows for all kinds of optimizations (e.g. a pipelined
>    memory architecture)

It moves the cost it doesnt make it vanish

If I read you right you are arguing for a second processor running
Linux.with its own independant memory bus. AMD make those already its
called AMD64. I don't know anyone thinking at that level about
partitioning one as an I/O processor.


