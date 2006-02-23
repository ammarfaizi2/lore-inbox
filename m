Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWBWGIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWBWGIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 01:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWBWGIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 01:08:31 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:58605 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750850AbWBWGIb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 01:08:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ifAkWXwdF1c1YzStipXnUsf7mQaCwTW4v+pyI5c/C4WBIIq4LnPzRDL253EshwUIzVQOre3abWXM4aTKegLESQDc6qwLJMaH2j6LDLl6y2mt/jhKajCR+/Onei/doQhhugMSLUFpO1qhh2lwrEvhoLdHRjcLCUC2Gf63ZmzIKYE=
Message-ID: <7a37e95e0602222208i9a7c973vc50ac336fb174024@mail.gmail.com>
Date: Thu, 23 Feb 2006 11:38:30 +0530
From: "Deven Balani" <devenbalani@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: non-PCI based libata-SATA driver
Cc: linux-kernel@vger.kernel.org, Linux-arm-kernel@lists.arm.linux.org.uk
In-Reply-To: <1140654191.8672.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7a37e95e0602220404y7b82104ch5c3cda087336aed7@mail.gmail.com>
	 <1140654191.8672.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you look at http://zeniv.linux.org.uk/~alan/IDE you'll find the PATA
> patches I did include some VLB and ISA devices.
Thanks a lot. I'm going through these patches and will get back to you
in case of any problem.

I have a SATA Controller that is attached to HSX bus on ARM based
chipset. On this side, I'm exploring the feasibilty of coming up with
low-level libata-SATA driver (as libata is being said to support
generic bus interface). I've gone through the SATA drivers in kernel
code but all seem to be PCI specific.

Also, Is there any slight possiblity of doing the same with 2.4.x
kernels (by patching the kernel or whatever)?

Any suggestion/comments/advice will be of great help.

Thanks in advance.

Deven

On 2/23/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2006-02-22 at 17:34 +0530, Deven Balani wrote:
> > Hi all
> >
> > I'm working on writing a non-PCI based libata-SATA driver in
> > linux-2.6.x for ARM based chipsets.
> >
> > Can anybody suggest me a reference-code for a non-PCI based
> > libata-SATA driver for  2.6.x kernels ?
>
> If you look at http://zeniv.linux.org.uk/~alan/IDE you'll find the PATA
> patches I did include some VLB and ISA devices. Providing you've got a
> struct device * for whatever your SATA controller is (ie a bus model of
> some sort) it is sane. If you don't then you need a couple of small
> patches to allow for this, or to add device model stuff to them first. I
> can send you those if need be and they are in the patches but not
> seperated out.
>
>
>
> Alan
>
>


--
"A smile confuses an approaching frown..."
