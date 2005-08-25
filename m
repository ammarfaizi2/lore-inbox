Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVHYRA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVHYRA7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 13:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVHYRA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 13:00:58 -0400
Received: from ns1.heckrath.net ([213.239.205.18]:39400 "EHLO
	mail.heckrath.net") by vger.kernel.org with ESMTP id S1751073AbVHYRA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 13:00:58 -0400
Date: Thu, 25 Aug 2005 21:01:48 +0200
From: Sebastian Kaergel <mailing@wodkahexe.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       sylvain.meyer@worldonline.fr
Subject: Re: Linux-2.6.13-rc7
Message-Id: <20050825210148.4f60e531.mailing@wodkahexe.de>
In-Reply-To: <430DF08C.8010604@gmail.com>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
	<20050825194954.6db42e90.mailing@wodkahexe.de>
	<430DF08C.8010604@gmail.com>
X-Mailer: Sylpheed version 2.0.0beta6 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005 00:23:40 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> Sebastian Kaergel wrote:
> > On Tue, 23 Aug 2005 22:08:13 -0700 (PDT)
> > Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> >> Sylvain Meyer:
> >>   intelfb: Do not ioremap entire graphics aperture
> 
> Probably this one. If vram is less than stolen size, intelfb
> will only ioremap the framebuffer memory, excluding the
> ringbuffer and the cursor memory.
> 
> Try booting with video=intelfb:accel:0,nohwcursor:0.  If you get
> a display, try this patch.
> 
> CC'ed Sylvain.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
<patch snipped>

Hi,
thanks for your quick reply, but it did not work. the screen remains
black when booting with video=intelfb:accel:0,{,no}hwcursor:0
