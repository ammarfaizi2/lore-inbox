Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSKKMxj>; Mon, 11 Nov 2002 07:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264993AbSKKMxj>; Mon, 11 Nov 2002 07:53:39 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:42147 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264628AbSKKMxi>; Mon, 11 Nov 2002 07:53:38 -0500
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211101747420.12703-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211101747420.12703-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 13:24:56 +0000
Message-Id: <1037021096.2919.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 01:51, Linus Torvalds wrote:
> But considering that we don't use the static TSC knowledge very much any
> more, you might want to remove CONFIG_X86_TSC altogether, though, and
> replace its uses with run-time checks. We've done that with a lot of the
> other config stuff earlier (SSE/XMM) because the static compiled options
> are just too inconvenient and not worth the maintenance hassles..

Or we use the new config stuff to stick in

Twiddle Advanced Bits Y/N
	Include PPro fence fix
	Include ...
	Include ...
	

