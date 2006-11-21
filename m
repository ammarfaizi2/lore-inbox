Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030734AbWKUFks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030734AbWKUFks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 00:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030742AbWKUFks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 00:40:48 -0500
Received: from raven.upol.cz ([158.194.120.4]:19161 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1030734AbWKUFkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 00:40:47 -0500
Date: Tue, 21 Nov 2006 05:47:43 +0000
To: Marty Leisner <linux@rochester.rr.com>
Cc: Folkert van Heusden <folkert@vanheusden.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
Message-ID: <20061121054743.GA1282@flower.upol.cz>
References: <20061118010946.GB31268@vanheusden.com> <slrnelsomr.dd3.olecom@flower.upol.cz> <20061118020200.GC31268@vanheusden.com> <200611210349.kAL3mxt3015702@dell2.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611210349.kAL3mxt3015702@dell2.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 10:48:59PM -0500, Marty Leisner wrote:
[]
> > This is a user-space issue, not kernel (carrying this forward, we can
> say the "kernel should complain when programs have bugs").
> 
> Newer glibc has catchsegv (haven't found any documentation, but its
> interesting) --

It's just LD_PRELOAD (man ld.so) and libSegFault.so, which installs
(among others) SIGSEGV handler, see "glibc/sysdeps/generic/segfault.c".
____
