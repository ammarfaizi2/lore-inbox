Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272535AbTHRQnx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272540AbTHRQnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:43:53 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:5266 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S272535AbTHRQnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:43:53 -0400
Subject: Re: [PATCH] use simple_strtoul for unsigned kernel parameters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Jamie Lokier <jamie@shareable.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308180817360.1672-100000@home.osdl.org>
References: <Pine.LNX.4.44.0308180817360.1672-100000@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061225003.25041.34.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 18 Aug 2003 17:43:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-08-18 at 16:20, Linus Torvalds wrote:
> Well, in theory short/int/long can all be the same size and thus a
> "unsigned short" may not actually fit in a "long". I think that was the
> case on the old 64-bit cray machines, for example ("char" was a very slow
> 8-bit thing, everything else was purely 64-bit).
> 
> Not likely something we want to port Linux to, admittedly.

Bear in mind we have the compiler source 8). If someone desperately
wants to run Linux (probably ucLinux) on their cray they can fix the
types too.

Things like the DEC10 (9,18,36 bit) and HLH Orion (word addressed) would
be a lot more fun but thankfully are extinct 


