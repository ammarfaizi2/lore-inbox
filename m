Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWCBGXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWCBGXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 01:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWCBGXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 01:23:39 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:11710 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751144AbWCBGXj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 01:23:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y8GWnxr2WiRdmNMQuUGCdVQaafqtpIhljV1O7Vk51HLvVH/VgNYp9FQQgDI95QQhAuS/ZSkix+NIfJcq48i5u95GAOv0vMTcMLMuOeacr1SDy6VN6ZlyMui/kWmuHX2REzpziFYEtHpPRntuTXgcX7cqZrugKoGt35t7Fb+yEok=
Message-ID: <311601c90603012223j10aef3e0s3158567594bb9791@mail.gmail.com>
Date: Wed, 1 Mar 2006 23:23:37 -0700
From: "Eric D. Mudama" <edmudama@gmail.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Cc: "Mark Lord" <lkml@rtr.ca>, "Jens Axboe" <axboe@suse.de>,
       "Tejun Heo" <htejun@gmail.com>,
       "Nicolas Mailhot" <nicolas.mailhot@gmail.com>,
       "Mark Lord" <liml@rtr.ca>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Carlos Pardo" <Carlos.Pardo@siliconimage.com>
In-Reply-To: <44066400.6070503@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1141239617.23202.5.camel@rousalka.dyndns.org>
	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
	 <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
	 <44065C7C.6090509@pobox.com>
	 <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com>
	 <44066132.4010205@pobox.com> <44066378.1080408@rtr.ca>
	 <44066400.6070503@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Mark Lord wrote:
> > Jeff Garzik wrote:
> > ..
> >
> >> Sounds like un-blacklisting the drive, and adding ATA_FLAG_NO_FUA is
> >> the way to go...
> >
> >
> > Might as well add sata_mv to that blacklist as well.
>
> Have you confirmed that it doesn't work with FUA?

I'll see if I can find one of these around the lab tomorrow and test
the raw command support.  If that's fine at a basic level, it might be
a bug in the driver?
