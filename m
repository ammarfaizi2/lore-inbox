Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282190AbRLMLgq>; Thu, 13 Dec 2001 06:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283757AbRLMLgg>; Thu, 13 Dec 2001 06:36:36 -0500
Received: from t2.redhat.com ([199.183.24.243]:42486 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S282190AbRLMLg0>; Thu, 13 Dec 2001 06:36:26 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <BCF7BFC1D50@vcnet.vc.cvut.cz> 
In-Reply-To: <BCF7BFC1D50@vcnet.vc.cvut.cz> 
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: FBdev remains in unusable state 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Dec 2001 11:35:21 +0000
Message-ID: <8895.1008243321@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


VANDROVE@vc.cvut.cz said:
> Documentation/fb/vesafb.txt, X11 paragraph, last sentence:
> -------8<----- 
> The X-Server must restore the video mode correctly, else you end up
> with a broken console (and vesafb cannot do anything about this).
> -------8<----- 

This isn't strictly true. We could just call the VESA BIOS to set it up
again for us. The 'vesa' XFree86 driver manages to do this perfectly well
from userspace, even.

--
dwmw2


