Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277266AbRJJP1H>; Wed, 10 Oct 2001 11:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277271AbRJJP06>; Wed, 10 Oct 2001 11:26:58 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:59146 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S277266AbRJJP0l>;
	Wed, 10 Oct 2001 11:26:41 -0400
Date: Wed, 10 Oct 2001 17:27:09 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: low-latency patches
To: alan@lxorguk.ukuu.org.uk,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3BC468CD.5A2C8FF4@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox (alan@lxorguk.ukuu.org.uk) wrote :
> > Right. It needs to be a conscious, planned decision: "from now on, 
> > holding a lock for more than 500 usecs is a bug". 
> 
> Firstly you can start with "of course some hardware will stall the bus 
> longer than that" 

So ?

Some hardware miscalculates certain floating point operations,
but we still use FPUs.

Some ethernet cards corrupt the packets, but Linux still supports ethernet.

Some IDE hardrives lock up in DMA mode, yet Linux still supports DMA.

Some softmodems don't work at all, yet Linux still support modems.

There is always buggy hardware in every category. No reason to not use the good ones.

david, just being a PITA ...

-- 
David Balazic
--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
