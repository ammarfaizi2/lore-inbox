Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSIIKK3>; Mon, 9 Sep 2002 06:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSIIKK2>; Mon, 9 Sep 2002 06:10:28 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:30482 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S316957AbSIIKJ4>; Mon, 9 Sep 2002 06:09:56 -0400
From: zwane@mwaikambo.name
Subject: Re: [PATCH][RFC] per isr in_progress markers
To: bert hubert <ahu@ds9a.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
X-Originating-IP: 196.28.7.236
X-Mailer: Webmin 0.940
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bound1031566421"
Message-Id: <20020909101341.2E3B2BC51@hemi.commfireservices.com>
Date: Mon,  9 Sep 2002 06:13:41 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--bound1031566421
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

bert hubert <ahu@ds9a.nl> wrote ..
> On Sun, Sep 08, 2002 at 03:01:02PM -0700, Linus Torvalds wrote:
> 
> >    setups (as opposed to most laptops, which often seem to put every PCI
> >    device on the same irq)
> 
> I've always thought that this was a linux problem - any reason *why* laptops
> do this?

Hi Bert,
   I'd presume the reason for that would be because the irq/pin mappings end up in a manner that all the devices end up having the same irq assigned to the pin they're using. This would be a BIOS/fw problem, although it can be alleviated with PCI IRQ router support for that particular chipset.

     Zwane

--bound1031566421--
