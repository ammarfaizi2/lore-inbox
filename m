Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbSKQWT4>; Sun, 17 Nov 2002 17:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266975AbSKQWTz>; Sun, 17 Nov 2002 17:19:55 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:46258 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266970AbSKQWTz>; Sun, 17 Nov 2002 17:19:55 -0500
Subject: Re: 2.5.47-ac5 compile failure: missing linux/iobuf.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Glenn C. Hofmann" <ghofmann@pair.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Evans <spse@secret.org.uk>
In-Reply-To: <1037556071.12239.13.camel@hofmann1.gchofmann.org>
References: <1037556071.12239.13.camel@hofmann1.gchofmann.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Nov 2002 22:54:14 +0000
Message-Id: <1037573654.5356.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-17 at 18:05, Glenn C. Hofmann wrote:
> While trying to compile blkmtd.c it cannot find linux/iobuf.h.  This is
> due to the fact that it isn't there.  Searching the lkml archives, there
> is no mention of this file being removed nor of anybody else having this
> issue, that I can find.

Its quite possible nobody else is trying to use blkmtd.c. You may just
be able to remove the now imaginary header

