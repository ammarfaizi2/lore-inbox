Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWFTUfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWFTUfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWFTUfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:35:31 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:61304 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750953AbWFTUfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:35:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g4WAMk+laGi6CH9aNr8c4L1XBhUK3lYyMaaaf01o0FfZYW2bsB65ukmMWwiqeCaeg2sjJiZ3LUMGwFFjmN4CLbh/gCqniAhtsGeWGMpVHwBwRchzPk+JkMh5+kiJHZ8RlVwGSIc/DsMVMpurf+3/t3XfQzv9LEzCXojbKViTiGA=
Message-ID: <7f45d9390606201335x29957bfcy31dd4ece97d551ea@mail.gmail.com>
Date: Tue, 20 Jun 2006 14:35:29 -0600
From: "Shaun Jackman" <sjackman@gmail.com>
Reply-To: "Shaun Jackman" <sjackman@gmail.com>
To: "Paul Fulghum" <paulkf@microgate.com>
Subject: Re: TL16C752B DUART: MCR_OUT2 disables interrupts
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44985A07.9080807@microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7f45d9390606201307yfdb8aadn4d00a6afeba0b09b@mail.gmail.com>
	 <44985A07.9080807@microgate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/06, Paul Fulghum <paulkf@microgate.com>
> The old 16550 OUT2 output (MCR:3) used to be a truly
> independant control output that was commonly used
> with an external gate to connect/disconnect the
> interrupt request to the ISA bus.
>
> Reading the TL16C752B datasheet, it seems pretty clear
> that this gating is performed internal to the device.
> MCR:3 is no longer an independant, general purpose I/O.
>
> The result is the same though: If you dink around with
> MCR:3 you could disable interrupts in either case.
>
> So I don't see this as more or less of a problem than
> other 16550 type devices.

I didn't know of this historic use of the OUT2 pin to disable
interrupts. I'll put OUT2 on my list of things not to muck with. Is
there any similar historic use of OUT1?

Cheers,
Shaun
