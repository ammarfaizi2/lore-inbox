Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbVKCV3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbVKCV3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbVKCV3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:29:09 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:63953 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030494AbVKCV3I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:29:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MI7PIr7v7vTXWcbd+9e+ihVjcyyMDcFvWa3IkZb8XX9X/hH07vGG+rsedpTSAb677k69o4/fiEe496D3T1cl/nqAIDtc35aoyi+ZkZtVJLmuGqaDp17KcLt6Rk98Xt3KEBif/Xhsccm2ePwlM9ui0zEArmBmiMWsygy00fOPhCg=
Message-ID: <58cb370e0511031329h7532259y6d3624fbf2d93f88@mail.gmail.com>
Date: Thu, 3 Nov 2005 22:29:07 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Parallel ATA with libata status with the patches I'm working on
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <m3oe51zc2e.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
	 <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
	 <m3oe51zc2e.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:
>
> > IMO porting/rewriting host-drivers to libata now is just
> > counter-productive waste of time...
>
> That would only make sense if you consider all PATA obsolete/dead
> (do you? I'm sometimes not sure).

I want to merge old IDE driver w/ libata... and drop remaining crap on the way.
If libata gains full PATA support before I do this - it is even better for me...

> I don't and (unable to use old IDE due to hot-plug issues) am thankful
> for Alan's efforts.

Do you think that libata is currently so much better wrt to PATA
hot-(un)plug support?

If so than dream on...

> Yes, I think it's similar to OSS-ALSA, WRT - you know, 6-months forward
> notice etc :-)

Ain't going to happen...

Guys, I'm not against libata PATA support - I'm all for it but I want
TRANSPARENT development and FAIR look at current state of affairs
(there is still a lot of stuff on libata's PATA TODO)...

Plus I don't like needless bashing of IDE driver which is still messy
but orders of magnitude less than during 2.4.x days... :-)

Bartlomiej
