Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWB1Q5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWB1Q5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 11:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWB1Q5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 11:57:35 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:14241 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751821AbWB1Q5d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 11:57:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PL/1YOuTTM0WlUAa77JLQQLW2Tz8137xumfHjprjORp+lu12jpUBRSiMrpgaBsCaS1GHw2Ih7NJXIGStfIMFyC5H+rNuehtaPsdyZ9jUx+jDdUOI76L/WznqOT2g4DtpgmeeUz95fqhMD8qSkNG5WqgushduRVSVoCYRvwU2408=
Message-ID: <311601c90602280857x3f102af5l31c9a0ac1a896b4e@mail.gmail.com>
Date: Tue, 28 Feb 2006 09:57:31 -0700
From: "Eric D. Mudama" <edmudama@gmail.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Cc: "Mark Lord" <liml@rtr.ca>, "David Greaves" <david@dgreaves.com>,
       "Tejun Heo" <htejun@gmail.com>,
       "Justin Piszcz" <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       "IDE/ATA development list" <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <44046D86.7050809@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602140439580.3567@p34> <4401122A.3010908@rtr.ca>
	 <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca>
	 <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
	 <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com>
	 <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

those drives should support all FUA opcodes properly, both queued and unqueued

On 2/28/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Mark Lord wrote:
> > David Greaves wrote:
> >
> >>
> >> scsi1 : sata_sil
> >>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
> >>   Type:   Direct-Access                      ANSI SCSI revision: 05
> >>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
> >>   Type:   Direct-Access                      ANSI SCSI revision: 05
> >
> >
> > I wonder if the non-FUA component here is the sata_sil,
> > rather than the two Maxtor drives.
> >
> > Also, your drives have different firmware,
> > but both have trouble with FUA here.
>
> sata_sil is indeed a piece of hardware that needs to know the opcodes
> ahead of time...
>
>         Jeff
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
