Return-Path: <linux-kernel-owner+w=401wt.eu-S932083AbXAINyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbXAINyG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 08:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbXAINyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 08:54:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:23749 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbXAINyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 08:54:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F8f7JRkZEbYq/OQL7rLAIUm0KQGd0j2rKQsZ/Wwi07EFB/kUO4fyULdbNSI4o8j05FGX/BrsBexP57Rat0HUhB1FmWzpx4YpTyfq3T532Lc5LSdIBWbbEGvRpnxTvDH66GbBxBB7/0GP17+DwDjV6VZyZsnNKBa47yPgRjZZitQ=
Message-ID: <58cb370e0701090554s6aa3d1derc7d2188598644d79@mail.gmail.com>
Date: Tue, 9 Jan 2007 14:54:01 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH 3/3] atiixp.c: add cable detection support for ATI IDE
Cc: "Conke Hu" <conke.hu@gmail.com>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>,
       linux-ide@vger.kernel.org
In-Reply-To: <45A392C7.1030309@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5767b9100701060422p1abd1d21x606b758220815551@mail.gmail.com>
	 <58cb370e0701061816s308155abw719a00d499f504ea@mail.gmail.com>
	 <5767b9100701090453g51448661td14e4c05a4eceb2a@mail.gmail.com>
	 <45A392C7.1030309@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The good news is that it doesn't matter now as Andrew fixed Conke's patches
manually and applied them to -mm [ but without my Acked-by-s :( ].

On 1/9/07, Jeff Garzik <jeff@garzik.org> wrote:
> Conke Hu wrote:
> > ------------------------
> > --- linux-2.6.20-rc4/drivers/ide/pci/atiixp.c.3    2007-01-09
> > 15:37:42.000000000 +0800
> > +++ linux-2.6.20-rc4/drivers/ide/pci/atiixp.c    2007-01-09
> > 15:40:08.000000000 +0800
> > @@ -291,8 +291,12 @@ fast_ata_pio:
>
>
> Your patches are still getting word-wrapped...
>
>         Jeff
