Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316422AbSEOPwi>; Wed, 15 May 2002 11:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316427AbSEOPwh>; Wed, 15 May 2002 11:52:37 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:48805 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S316422AbSEOPwg>;
	Wed, 15 May 2002 11:52:36 -0400
Date: Wed, 15 May 2002 17:52:29 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: greg@kroah.com
cc: linux-kernel@vger.kernel.org
Subject: BUG and OOPS in USB-OHCI again
Message-ID: <Pine.LNX.4.44.0205151742210.12674-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I read post of some people having problems with OHCI. Well
I'm having them too.
We use pwc.o module (without closed-source compression support)
on two machines with OHCI add-on card.
It fails regulary (twice a day) with:
BUG at usb-ohci.h:464 and it panics. With onboard UHCI it works
well !! When I sumarized other posts on the list we can see that
there was the same problems with OHCI+modem so that the bug
should not be related to camera.
Kernel is vanilla 2.4.18.

Any tips ?

devik

