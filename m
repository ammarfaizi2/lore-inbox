Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVKRR7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVKRR7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVKRR73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:59:29 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:34476 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030251AbVKRR73 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:59:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fiBoYvdpJJioekrcncpiVV8tFbbSS6J/2XNY9RQOHVKP3A6CT1Th+htkRn8sCYvoVoCRqT59wAis3exAdpJ762RhwPleW/0m/5lH9jNqz7sv9lZsSPe4alSGtty/gtEt3gIhbSa4EXdr7oe/mb2jX0GWaa4ipTr1nXcPrNjLvIo=
Message-ID: <c775eb9b0511180959r12206562h5a294d9505d95d04@mail.gmail.com>
Date: Fri, 18 Nov 2005 12:59:28 -0500
From: Bharath Ramesh <krosswindz@gmail.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: intel8x0 sound of silence on dell system
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051118162300.GA22092@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051118162300.GA22092@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably the sound car is muted. you might want to try out the
alsamixer to unmute the card.

On 11/18/05, Benjamin LaHaise <bcrl@kvack.org> wrote:
> Hello all,
>
> On trying out head on my workstation, it seems that no sound comes out.
> The module is getting loaded and the interrupts line for the 'Intel ICH5'
> is increasing.  The RHEL 4 kernel is known to work on this machine.  The
> only output from the driver is below.  Any ideas?
>
>                 -ben
>
> intel8x0_measure_ac97_clock: measured 51314 usecs
> intel8x0: clocking to 48000
> --
> "Time is what keeps everything from happening all at once." -- John Wheeler
> Don't Email: <dont@kvack.org>.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
