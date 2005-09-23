Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVIWPkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVIWPkp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 11:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVIWPkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 11:40:45 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:1383 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751084AbVIWPko convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 11:40:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sWS145/VTZn1XGgj8Nqoxed+S1lW99oOZhs8ZuE54Mw5VCeR+q02a+vpmEfkjPgNuoL4S6bkHAODsUJFe8CC5d6L5JWqqweK+ssWU+WwTfteAVIBWwMTwMHzwMPupZtSG3Mp8qCQEYAwsk/2LvhcBIUYI/HzFdDiNBHonqzO838=
Message-ID: <58cb370e05092308406d1b9dc1@mail.gmail.com>
Date: Fri, 23 Sep 2005 17:40:42 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.13] drivers/ide: Enable basic VIA VT6410 IDE functionality
Cc: Robert Kesterson <robertk@robertk.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <1127399297.18840.92.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <op.sxg2dxd5wc4mme@new.robertk.com>
	 <1127399297.18840.92.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2005-09-21 at 16:38 -0500, Robert Kesterson wrote:
> > This patch enables plain IDE functionality on the VIA VT6410 IDE controller
> > (such as used on the Asus P4P800 Deluxe motherboard).
>
> Mathias Kretschmer posted a patch several months ago, and Daniel Drake
> reposted it on August 30th if you check the archive. Bartlomiej was

No, this patch is an earlier reincarnation
(it changes generic.c instead of via82cxxx.c).

> asked to respond to/merge it but if he responded I didn't see it so it
> was probably a private reply.

Bartlomiej responded the same day (cc:ing linux-kernel and linux-ide)
and asked Daniel to fix via82cxxx.c to support multiple controllers.

Daniel sent me patch 2 days later but I still need to go through it
(I've been away for 3 weeks).

Bartlomiej
