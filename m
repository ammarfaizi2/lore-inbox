Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932833AbWFVHw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbWFVHw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932835AbWFVHw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:52:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:3067 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932833AbWFVHw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:52:56 -0400
Message-ID: <449A4C5F.4040106@manoweb.com>
Date: Thu, 22 Jun 2006 09:53:03 +0200
From: Alessio Sangalli <alesan@manoweb.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] cardbus: revert IO window limit
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI> <20060622001104.9e42fc54.akpm@osdl.org>
In-Reply-To: <20060622001104.9e42fc54.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:98b9443de46bd48dbf34b16449aa5d76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>> -#define CARDBUS_IO_SIZE		(256)
>> +#define CARDBUS_IO_SIZE		(4*1024)

> There is something bad happening in there.  Presumably, this patch will
> break the ThinkPad 600x series machines again though.
> 
> It'd be nice if this was related to
> http://bugzilla.kernel.org/show_bug.cgi?id=6725, but I guess not.

To be honest, I did not try any pcmcia devices lately. I will test the
machine with various kernels and let you know the results.

> Didn't all this stuff work in 2.4?

I will also test the machina with a recent 2.4. Just let me know if I
should try out a very particular version,

thank you
Alessio Sangalli


