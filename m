Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274833AbRIUVAJ>; Fri, 21 Sep 2001 17:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274834AbRIUVAE>; Fri, 21 Sep 2001 17:00:04 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:16653 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S274833AbRIUU7p>; Fri, 21 Sep 2001 16:59:45 -0400
Message-Id: <200109212100.f8LL08Y61889@aslan.scsiguy.com>
To: Ray Bryant <raybry@timesn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: AIC-7XXX driver problems with 2.4.9 and L440GX+ 
In-Reply-To: Your message of "Fri, 21 Sep 2001 15:58:28 CDT."
             <3BABA9F4.3677E423@timesn.com> 
Date: Fri, 21 Sep 2001 15:00:08 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The AIC-7XXX version 6.2.1 driver hangs at startup under 2.4.x  (we've
>tried 2.4.2-2 (RH 7.1), 2.4.5, and 2.4.9).
>The complete boot output is attached; the interesting parts are 
>as follows:

This again looks like an interrupt problem (driver not seeing interrupts).
To know for sure, I'd need to see the messages from an "aic7xxx=verbose"
boot.

--
Justin
