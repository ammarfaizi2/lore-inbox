Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVIKD42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVIKD42 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 23:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVIKD42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 23:56:28 -0400
Received: from colin.muc.de ([193.149.48.1]:55303 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932322AbVIKD41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 23:56:27 -0400
Message-ID: <20050911035621.87661.qmail@mail.muc.de>
From: ak@muc.de
Date: 11 Sep 2005 05:56:21 +0200
To: Rik van Riel <riel@redhat.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
In-Reply-To: <Pine.LNX.4.63.0509101028510.4630@cuia.boston.redhat.com>
References: <20050910041218.29183.qmail@web51612.mail.yahoo.com> <Pine.LNX.4.63.0509101028510.4630@cuia.boston.redhat.com>
Date: Sun, 11 Sep 2005 05:56:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.linux.scsi, you wrote:
> On Fri, 9 Sep 2005, Luben Tuikov wrote:
>
>> No self respecting SAS chip would not do 64 bit DMA, or have an sg 
>> tablesize or any other limitation.
>> 
>> Naturally, aic94xx has _no limitations_. :-)  But hey, our hardware just 
>> kicks a*s!
>
> That's very nice for you - but lets face it, a SAS layer
> that'll be unable to also deal with the El-Cheapo brand
> controllers isn't going to be very useful.

Nobody knows what these bu^wlimitations will be though. So you cannot
really plan for them in advance.  When someone writes drivers for such 
limited hardware they can add code to handle the limitations. But it 
seems reasonable to start with a clean hardware model, and only
add the hacks later when they are really needed and the requirements
are understood.

-Andi
