Return-Path: <linux-kernel-owner+w=401wt.eu-S1750864AbXAKQvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbXAKQvZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbXAKQvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:51:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:20176 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbXAKQvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:51:24 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tTTuj5Eo0ddFxZLkeqJ9mCTx0vZ0T1cUkLF91Z0KdeprZRzG91mBzch7VUq0Cr0dMeriu0p+5lQ6+gyLyWiMQUJK/I8IMeVAGGPRT3WW4X8QDrk91Gsz//AKTe94BiNxf6NjueHYn5LQe6JtblFXnNA3pfvLCfj953GJ0g39q5U=
Message-ID: <58cb370e0701110851r2da0be97pdba5140645cc5bf4@mail.gmail.com>
Date: Thu, 11 Jan 2007 17:51:22 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] let BLK_DEV_AMD74XX depend on X86
Cc: "Adrian Bunk" <bunk@stusta.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20070111164853.5de4ddfa@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070111134917.GE20027@stusta.de>
	 <20070111164853.5de4ddfa@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> On Thu, 11 Jan 2007 14:49:17 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
>
> > It's unlikely that this driver will ever be of any use on other
> > architectures.
> >
> > This fixes the following compile error on ia64:
>
> NAK
>
> pci_get_legacy_ide_irq() is a required method for all platforms and is
> usually filled in by asm-generic/pci.h
>
> Please fix the IA64 tree to do the right thing.

I've already sent a patch do do this...

http://lkml.org/lkml/2007/1/11/118
