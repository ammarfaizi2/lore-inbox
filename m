Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVBCWXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVBCWXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVBCWXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:23:42 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:29972 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262698AbVBCWXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:23:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tPopuRkAdk0qWxMEBV5vvRGHY0pklWQkflbB50hE/JBwaL31c4aKOjCOrMYEZVD5I+dcwV2yO1zuGacrj+Jz8DdaLP3NuHyyK3dBkKf/+v4KXbKgEKXJKe2uTnOMGv6TUH0EApvMBbgSbNBC0uXBCTfWFXp1fSX2THFRPAyltuE=
Message-ID: <58cb370e05020314231d3237d9@mail.gmail.com>
Date: Thu, 3 Feb 2005 23:23:06 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: via82cxxx resume failure.
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4202A25A.9050700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1105953931.26551.314.camel@hades.cambridge.redhat.com>
	 <58cb370e05020312296060f4bf@mail.gmail.com>
	 <4202A25A.9050700@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2005 17:14:50 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Sorry for the delay.
> >
> > On Mon, 17 Jan 2005 09:25:30 +0000, David Woodhouse <dwmw2@infradead.org> wrote:
> >
> >>On resume from sleep, via_set_speed() doesn't reinstate the correct DMA
> >>mode, because it thinks the drive is already configured correctly. This
> >>one-line hack is sufficient to make it refrain from dying a horrible
> >>death immediately after resume, but presumably has other problems...
> >
> >
> > I applied this to libata-dev so it gets some testing in -mm.
> 
> Chuckle -- you mean ide-dev, presumably :)

yes, obviously :)
