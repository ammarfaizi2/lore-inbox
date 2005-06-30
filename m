Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263080AbVF3UYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbVF3UYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVF3UXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:23:34 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:55679 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263080AbVF3UT6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:19:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Av1vNaZOEBDbX9ERAM5w5r77ni5JuHksAWj4kJESFKpm2F1/Q0WP8CCxbFzOKjzr5CTsHo2v2NLkq0v/XoaZ2HNo9DAjWldEoccMtxbYBd6xlze38d/zxoRXRAzeNj/sMSqaqKPT2P1XYzpawBU7KhP5y2u3+PAhGyrhx9tBtz0=
Message-ID: <2e3c17f30506301319704f6de0@mail.gmail.com>
Date: Thu, 30 Jun 2005 13:19:55 -0700
From: Fedor Karpelevitch <fedor.karpelevitch@gmail.com>
Reply-To: fedor@karpelevitch.net
To: Stefan Seyfried <seife@gmane0305.slipkontur.de>
Subject: Re: [ACPI] Re: AE_NO_MEMORY on ACPI init after memory upgrade and oops
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050630194954.GA20844@message-id.s3e.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506300042.22255.fedor@karpelevitch.net>
	 <20050630084426.GA30436@message-id.gmane0305.slipkontur.de>
	 <200506300618.15109.fedor@karpelevitch.net>
	 <20050630194954.GA20844@message-id.s3e.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/6/30, Stefan Seyfried <seife@gmane0305.slipkontur.de>:
> On Thu, Jun 30, 2005 at 06:18:13AM -0700, Fedor Karpelevitch wrote:
> > Stefan Seyfried wrote:
> > > On Thu, Jun 30, 2005 at 12:42:19AM -0700, Fedor Karpelevitch wrote:
> > > > I tried to upgrade memory on my laptop from 2 x 128m by replacing
> 
> > > Did you override your DSDT?
> >
> > Yes, I did.
> 
> So you need to modify your _new_ _original_ DSDT again after the memory
> upgrade.
> AFAIK the DSDT contains numbers that depend on the amount of memory and
> is often built dynamically by the BIOS => even changing some BIOS settings
> may change the DSDT.
> --
> Stefan Seyfried

Thanks! I'll try it out. I thought DSDT was static...

Fedor
