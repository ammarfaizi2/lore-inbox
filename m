Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753139AbWKFOKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbWKFOKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbWKFOKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:10:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:62852 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753139AbWKFOKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:10:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J90fNkthSrsRLncGMTfCoQBe9EdhuP4AhiPB2alepnNaVk65rq7L7d31ZPC4TgX6x0nAkD4TjZIbeGpm9KfQ+UKb9z6aTWQf1iIHzLUBPoT+nJgbTiG0ona4HovkY57oQ/eKOOpY0YUK0+T6EDpS8QQubwC6euqgzqj/NyMs60c=
Message-ID: <5767b9100611060610s6ac551cfwac97be19f075a0b6@mail.gmail.com>
Date: Mon, 6 Nov 2006 07:10:30 -0700
From: "Conke Hu" <conke.hu@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add pci revision id to struct pci_dev
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1162819681.1566.63.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5767b9100611060440i1149e0e3v2162e0604db10da7@mail.gmail.com>
	 <1162819681.1566.63.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-11-06 am 20:40 +0800, ysgrifennodd Conke Hu:
> > Hi all,
> >     PCI revision id had better be added to struct pci_dev and
> > initialized in pci_scan_device.
>
> You can read the revision any time you like, we don't need to cache a
> copy as we don't reference it very often
>
>

I've searched the kernel soruce code and it seems that the revision id
is widely used in pci drivers.
