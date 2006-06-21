Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWFUNer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWFUNer (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWFUNer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:34:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:42899 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932145AbWFUNeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:34:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oT9bMDzl2M+mEqNcU2TXVf7718hNtHogpUzq9nK/kLs/n5WjfBz1XExfquAHo0SXkngBG91kaBYKM4ahnxF/DWb4qFpgRWwnIlddnQsaM9TpTQE6piUHuU6SQ6lsGc1VTTZ9yyWtnk/r9TdVvq9K3LOS3BpqEGK9uoxeb3V/jzk=
Message-ID: <170fa0d20606210634t1ee3d186gd638feefd64d247d@mail.gmail.com>
Date: Wed, 21 Jun 2006 09:34:45 -0400
From: "Mike Snitzer" <snitzer@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver for PDC202XX
Cc: Erik@echohome.org, linux-kernel@vger.kernel.org
In-Reply-To: <1150896840.15275.62.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAMbmKIDqIQhHt6BBy4E2zd0BAAAAAA==@EchoHome.org>
	 <1150887073.15275.34.camel@localhost.localdomain>
	 <23064.216.68.248.2.1150895349.squirrel@www.echohome.org>
	 <1150896840.15275.62.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Mer, 2006-06-21 am 09:09 -0400, ysgrifennodd Erik Ohrnberger:
> > noticed that it was working against linux-2.6.17-rc4-ide1, so I renamed
> > the linux-2.6.17 to linux-2.6.17-rc4-ide1 and zcat | patch -p0.
>
> Get linux-2.6.17-ide1.gz instead of the rc4 patch

I have a PDC20267 and tried out 2.6.17 + linux-2.6.17-ide1.gz  The
resulting pata_pdc202xx_old module didn't initialize the controller on
boot (via initrd).  Is there some other CONFIG option or linux cmdline
that should be used?

thanks.
