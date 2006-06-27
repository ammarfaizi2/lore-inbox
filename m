Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWF0Ife@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWF0Ife (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWF0Ife
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:35:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:41297 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751245AbWF0Ifd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:35:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rbnRXK5Suim5QDqRF+q7PLZuDy0nop7gUi/PW8ckfszqvSWRd5WY3FX7wdZl9L5UYVj+529kVDrj+I1YQm9g2ItTvEj+2NDSyZgMbT4j0/G61SeoykBU0A1BKDbuK44rgsvHNt6BFm2WUYWa2sue4I2CuckS2o3WSJXTBwXgE9g=
From: Patrick McFarland <diablod3@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IPWireless 3G PCMCIA Network Driver and GPL
Date: Tue, 27 Jun 2006 04:37:57 -0400
User-Agent: KMail/1.9.1
Cc: Charles Majola <chmj@rootcore.co.za>, Pavel Machek <pavel@ucw.cz>,
       stephen@blacksapphire.com, benm@symmetric.co.nz,
       kernel list <linux-kernel@vger.kernel.org>, radek.stangel@gmsil.com
References: <20060616094516.GA3432@elf.ucw.cz> <449BEABD.5010305@rootcore.co.za> <1151070837.4549.18.camel@localhost.localdomain>
In-Reply-To: <1151070837.4549.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606270437.59454.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 June 2006 09:53, Alan Cox wrote:
> Ar Gwe, 2006-06-23 am 15:21 +0200, ysgrifennodd Charles Majola:
> > Alan, can you please give me pointers on the tty changes since 2.6.12?
>
> The newest kernels have a replacement set of tty receive functions that
> use a new buffering system.
>
> http://kerneltrap.org/node/5473
>
> covers the changes briefly. The internals of the buffering changes are
> quite complex because Paul did some rather neat things with SMP locking
> but the API is nice and simple.
>
> Its fairly easy to express the old API in terms of the new one if you
> are doing compat wrappers as well

Actually, its rather neat that something as 'simple' as tty still gets heavily 
hacked on every once in awhile.

-- 
Patrick McFarland || www.AdTerrasPerAspera.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

