Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272822AbRIWUGq>; Sun, 23 Sep 2001 16:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272836AbRIWUGg>; Sun, 23 Sep 2001 16:06:36 -0400
Received: from t2.redhat.com ([199.183.24.243]:41209 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272817AbRIWUGV>; Sun, 23 Sep 2001 16:06:21 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3BAE24F4.4489CC4A@nyc.rr.com> 
In-Reply-To: <3BAE24F4.4489CC4A@nyc.rr.com> 
To: John Weber <weber@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel pcmcia 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Sep 2001 21:06:45 +0100
Message-ID: <12891.1001275605@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


weber@nyc.rr.com said:
> Is cardmgr absolutely necessary?  I don't use modules, so I don't
> really understand what cardmgr does that can't be done by the kernel
> at boot. -

Aside from loading modules, it also performs the matching between devices 
and drivers - rather than drivers registering a list of the devices they're 
capable of driving, as with other bus types, cardmgr is required to 'bind' 
devices to drivers.

The whole lot wants rewriting. I've been looking at it but don't have 
anything that even compiles. 


--
dwmw2


