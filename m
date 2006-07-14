Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161242AbWGNDyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242AbWGNDyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 23:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161247AbWGNDyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 23:54:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:53314 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161242AbWGNDyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 23:54:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uD84TeLUg0XQ85InJHras68XrEkuBBZf+kUDOTfFmgJO6CzdpCTPjq8hL98eTAmCrihumKMx1Y/DrLlB3SfBZx0r/TJcBAOorz9f1WMoce4wh5TqFNSs3GgXaAtv19CHs1FL65tDvXALRa6IxtdZvMM5F5tm1+/DeoumODj/hRU=
Message-ID: <bde732200607132054g3f0f6c25ke1f0c1756f768611@mail.gmail.com>
Date: Fri, 14 Jul 2006 11:54:00 +0800
From: "cjacker huang" <cjacker@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH v1] ata_piix: attempt to fix
Cc: "Jeff Garzik" <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, albertcc@tw.ibm.com
In-Reply-To: <20060713235038.GA3613@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060711160202.GA2503@havoc.gtf.org>
	 <20060713235038.GA3613@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had test the ata-piix fix patch for kernel-2.6.17 and kernel-2.6.18rc1-mm1.

my sata controller is 0x8086 0x8020, that is to say, it is ICH8.

It works for me. long boot delay disappears.



2006/7/14, Greg KH <greg@kroah.com>:
> On Tue, Jul 11, 2006 at 12:02:02PM -0400, Jeff Garzik wrote:
> > This patch attempts to address problems on ata_piix that people have
> > been reporting:  long boot delay, ghost devices, and ICH8 brokenness.
> >
> > Testing feedback is requested as soon as possible, so that we can
> > potentially stick this into 2.6.18-rc2.
> >
> > I'm booting up several boxes locally here, mainly ICH5 and ICH8, as well.
>
> Sorry for the delay, but no, this does not solve the timeout at boot for
> me.  Do you need the boot log messages?
>
> thanks,
>
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
