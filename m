Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVH3PM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVH3PM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVH3PM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:12:28 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:33738 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932183AbVH3PM1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:12:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KvnS6csY9/3d05cQEnCmQnF8cySG+wVH+/ofJIIVWRycd4pzxImtOKfFWmmd18ho929BiUuAqYHqYp+BIJ44BZw9k0dvB1QuqqMlae3eEyegPikWmKcQwj+Op8V91vYfX2qW2IFqJ4eUrtWHsUnfNKvci5IY8zpyJbX96Ewgp4U=
Message-ID: <58cb370e05083008121f2eb783@mail.gmail.com>
Date: Tue, 30 Aug 2005 17:12:22 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] Add VIA VT6410 support
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
In-Reply-To: <43146CC3.4010005@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43146CC3.4010005@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Daniel Drake <dsd@gentoo.org> wrote:
> Jeff/Bart,
> 
> Can of you please apply this to a git tree and get this included in 2.6.14.
> The patch is about 6 months old and has been included in Gentoo kernels for
> about 3 months, and we've recieved multiple success reports.
> 
> I sent a mail to Bart at the end of June asking about this, and Sergey Vlasov
> recently asked the same question on LKML. If the patch isn't acceptable then
> please at least say _something_ :)

Same thing as with VT6420 support:

I'm still concerned about VIA IDE chipset + VT6410 combo
(AFAIR I've also seen VT6410 on PCI add-on card but I can be wrong).

via82cxxx.c needs to be fixed to support multiple controllers first.

Thanks,
Bartlomiej
