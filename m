Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbTAJPWd>; Fri, 10 Jan 2003 10:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTAJPVC>; Fri, 10 Jan 2003 10:21:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47250
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265201AbTAJPUj>; Fri, 10 Jan 2003 10:20:39 -0500
Subject: Re: [2.4.20] e1000 as module gives unresolved symbol _mmx_memcpy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042211459.2706.9.camel@paragon.slim>
References: <1042206299.1694.12.camel@paragon.slim>
	 <1042211643.31612.2.camel@irongate.swansea.linux.org.uk>
	 <1042211459.2706.9.camel@paragon.slim>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042215336.31848.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 16:15:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 15:10, Jurgen Kramer wrote:
> a) a kernel build for a VIA C3 doesn't use MMX, userspace programs can
> still use it

Basically true. It might be instructive to do more benching on this with
the C3 and MMX especially if the new cores add full prefetch stuff

> b) Both kernel and userspace can't use MMX any more

MMX is designed to need no OS support. SSE/SSE2 do need OS helpers but
not MMX.

