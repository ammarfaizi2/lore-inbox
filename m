Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319102AbSHFOoa>; Tue, 6 Aug 2002 10:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319104AbSHFOoa>; Tue, 6 Aug 2002 10:44:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:28145 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319102AbSHFOo3>; Tue, 6 Aug 2002 10:44:29 -0400
Subject: Re: [PATCH] APM fix for 2.4.20pre1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy TARREAU <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20020806134328.GA587@pcw.home.local>
References: <20020806134328.GA587@pcw.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 17:07:09 +0100
Message-Id: <1028650029.18156.174.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 14:43, Willy TARREAU wrote:
> Hi Marcelo,
> 
> I resend you this patch against 2.4.19-rc5 which prevents my SMP box from
> randomly crashing at boot during APM initialization. It still applies to
> 2.4.20-pre1. Alan included it in 19-ac4 too. Basically, it forces bios
> calls to be made only from CPU0.

Doing the job right is a bit more complex than that. Thanks to your hint
I've actually got APM SMP working a lot better on multiple boxes now.
Marcelo - I may send you some cooler stuff but this one should be
applied anyway

