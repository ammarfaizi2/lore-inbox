Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135211AbRDLUVo>; Thu, 12 Apr 2001 16:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135214AbRDLUVZ>; Thu, 12 Apr 2001 16:21:25 -0400
Received: from denise.shiny.it ([194.20.232.1]:24027 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S135211AbRDLUVS>;
	Thu, 12 Apr 2001 16:21:18 -0400
Message-ID: <3AD60B74.87A9C6D0@denise.shiny.it>
Date: Thu, 12 Apr 2001 22:09:24 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx driver problems
In-Reply-To: <200104101505.f3AF5bs31859@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >I have two Adaptec 2930CU (ultra narrow) cards. I modified the driver to
> >make them work in ultra mode.
>
> Can you elaborate on what you had to modify ?

I just added AHC_ULTRA to the features of 7850

AHC_AIC7850_FE	= AHC_SPIOCAP|AHC_AUTOPAUSE|AHC_TARGETMODE|AHC_ULTRA,
                                                          ^^^^^^^^^^

> >Apr  3 23:05:10 Jay kernel: scsi1:0:4:0: Attempting to queue an ABORT message
>
> Please run your system with aic7xxx=verbose and send me the resulting
> messages.  You should also upgrade to v6.1.11 of the driver.

Plain v6.1.11 hangs. It prints scsi0: blah blah scsi1: sdfdfgsg, I hear the cd
spinning up and nothing more. The system doesn't crash completely because the
cursor don't stop blinking (I don't use a hw cursor). I think it's just
waiting
something will never arrive.

(ppc750)

Bye.


