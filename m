Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWACQyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWACQyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWACQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:54:17 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:64860 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932428AbWACQyP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:54:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ukJWApuWTQxZkqlLe38Fhd5zodzZFh5GEIOcAhtMXIKT30TUl64u8aM+c6hxGyJZl5PCubQ3TV67kplV5NM/iUrJqtIBN2msWFVw/uPmf8YVI1G9NwI/XURxvR0QsmveJeqba9EVyHlw7EuRjl9D+RRD/wgyjYzMe88x3o4N67Q=
Message-ID: <58cb370e0601030854j45f9af79gd594850926061326@mail.gmail.com>
Date: Tue, 3 Jan 2006 17:54:14 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Small fixes backported to old IDE SiS driver
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1136301581.22598.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1136301581.22598.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Some quick backport bits from the libata PATA work to fix things found
> in the sis driver. The piix driver needs some fixes too but those are
> way to large and need someone working on old IDE with time to do them.
>
> This patch fixes the case where random bits get loaded into SIS timing
> registers according to the description of the correct behaviour from
> Vojtech Pavlik. It also adds the SiS5517 ATA16 chipset which is not
> currently supported by the driver. Thanks to Conrad Harriss for loaning
> me the machine with the 5517 chipset.

Looks obviously correct.  Andrew, could you add it to -mm?

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Thanks,
Bartlomiej
