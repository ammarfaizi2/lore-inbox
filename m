Return-Path: <linux-kernel-owner+w=401wt.eu-S1751319AbXAIKsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbXAIKsx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXAIKsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:48:52 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:32585 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbXAIKsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:48:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qQSVmtHJyiXmTTgck/hbXN7BZ8swEBiWN0t3hmi9z4I+farS1rJy5HgjBDXnhmHpojh1IpB81bueD+fKyHLDkyatmC+7pWdxxG6x5oBphHr29EXfGT5JA/Wnw1UcrUjuIG+yumwNVekqIoYEOfCv3X08+WQ8wVxB1UxEGogzTRw=
Message-ID: <652016d30701090248y65b3ddd9rad2bb8869d56f90d@mail.gmail.com>
Date: Tue, 9 Jan 2007 16:33:51 +0545
From: "Manish Regmi" <regmi.manish@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: ATA streaming feature support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45A0AE76.40600@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <652016d30701062240w4756bc4m8fdb54070708fd81@mail.gmail.com>
	 <45A0AE76.40600@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/07, Jeff Garzik <jeff@garzik.org> wrote:
> Manish Regmi wrote:
> > Hi all,
> >   First of all sorry for bringing this topic again.
> > As discussed in  --> http://lkml.org/lkml/2006/5/5/47
> > The ATA Streaming feature set is not necessary to be in Kernel Space
> > (IDE driver). There is a suggestion creating user space library.
> >
> > But how is the user space apps going to use the commands like READ
> > STREAM DMA EXT (0x2A). Shouldn't there be some support in kernel which
> > setups up PRD tables  and all.
> > It doesn't seem to be possible.... is it?
>
> If you pass SG_IO addresses, they become DMA scatter/gather tables.
>
>         Jeff

Thank you for your answer.

But what about PATA disks. Is that ioctl supported in PATA disk?
I tried to give IDENTIFY command but it failed with invalid argument.

Regards
Manish Regmi
