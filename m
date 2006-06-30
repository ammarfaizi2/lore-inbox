Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWF3Iol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWF3Iol (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 04:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWF3Iol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 04:44:41 -0400
Received: from wx-out-0102.google.com ([66.249.82.194]:12819 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932132AbWF3Iok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 04:44:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OyipBKnuwOWYpvD0aikX4ow8Z7XbxZ5/178EWny25Cs5IDsdtbPKndxfgi/jOX6xmaBNCUH/S98aasr/n1+WhAmN856zPoSDCVa1y+Sa7J07hg1As+ZyvDn9jqdQsdj1UfJg8GmwVEjHlouYxrYb0EdzqQXkwbOm51g4QYmgRM4=
Message-ID: <39f633820606300144h21671f1agafb55d9972b9e40f@mail.gmail.com>
Date: Fri, 30 Jun 2006 10:44:39 +0200
From: "Robert Nagy" <robert.nagy@gmail.com>
To: "Jesse Barnes" <jbarnes@virtuousgeek.org>
Subject: Re: Intel RAID Controller SRCU42X in SGI Altix 350
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606291217.00040.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <39f633820606290818g1978866ap@mail.gmail.com>
	 <200606291132.51866.jbarnes@virtuousgeek.org>
	 <39f633820606291212v40b0016cl@mail.gmail.com>
	 <200606291217.00040.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know that it only works in EFI context. But I haven't seen the disk
attached to it. I am going to try forcing it to PCI mode.

2006/6/29, Jesse Barnes <jbarnes@virtuousgeek.org>:
> On Thursday, June 29, 2006 12:12 pm, Robert Nagy wrote:
> > I've tried the diff but there is no difference.
> > I've also tried to use the EFI driver from Intel, but that did not
> > work either.
>
> Yeah, using the EFI driver won't help at all, as it's only available in
> EFI context (it might let you boot of the raid but that's about it).
>
> If you applied the diff and recompiled the megaraid driver and still got
> the same error, I'm not sure what the problem is....
>
> Jesse
>
