Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276766AbRJUVOk>; Sun, 21 Oct 2001 17:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276768AbRJUVOa>; Sun, 21 Oct 2001 17:14:30 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:14515 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276766AbRJUVOW>; Sun, 21 Oct 2001 17:14:22 -0400
Date: Sun, 21 Oct 2001 17:14:58 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110212114.f9LLEwA08836@devserv.devel.redhat.com>
To: charles@bueche.ch, linux-kernel@vger.kernel.org
Subject: Re: USB mouse cause keyboard lock
In-Reply-To: <mailman.1003694581.31628.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1003694581.31628.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in this config, after working for a while (from 3 min to 2 hours), the
> keyboard suddenly locks completely.
>[...] 
> In the same config, a lot of keypresses are lost. I evaluate the ratio
> loss/good at 1-2%. This key loss problem is not at all present in the
> non-USB config.

I suspect your BIOS may be emulating PS/2 ports in some
broken way. Get into your BIOS setup and make sure you
have anything resembling "legacy" or "emulation" switched off.

Another thing, while using your USB mouse, touch the built-in
input device and see if this correlates with keyboard lockup.

-- Pete
