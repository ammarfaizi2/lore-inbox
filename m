Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSFGOaU>; Fri, 7 Jun 2002 10:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317287AbSFGOaT>; Fri, 7 Jun 2002 10:30:19 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:37629 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317286AbSFGOaS>; Fri, 7 Jun 2002 10:30:18 -0400
Subject: Re: [PATCH] 2.4.19-pre10 bug in disable_APIC_timer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joe Korty <joe.korty@ccur.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <200206062059.UAA14586@rudolph.ccur.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Jun 2002 16:23:56 +0100
Message-Id: <1023463436.25523.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-06 at 21:59, Joe Korty wrote:
> Marcelo,
>  This one bit me when I actually started using the (relatively) new
> services disable_APIC_timer() and enable_APIC_timer().  Enable_APIC_timer()
> is coded correctly; this patch fixes the bug in the disable service.

When is this getting called from a non boot up situation ?

