Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWBWATM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWBWATM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWBWATL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:19:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36277 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751483AbWBWATL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:19:11 -0500
Subject: Re: non-PCI based libata-SATA driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Deven Balani <devenbalani@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7a37e95e0602220404y7b82104ch5c3cda087336aed7@mail.gmail.com>
References: <7a37e95e0602220404y7b82104ch5c3cda087336aed7@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 00:23:10 +0000
Message-Id: <1140654191.8672.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-22 at 17:34 +0530, Deven Balani wrote:
> Hi all
> 
> I'm working on writing a non-PCI based libata-SATA driver in
> linux-2.6.x for ARM based chipsets.
> 
> Can anybody suggest me a reference-code for a non-PCI based
> libata-SATA driver for  2.6.x kernels ?

If you look at http://zeniv.linux.org.uk/~alan/IDE you'll find the PATA
patches I did include some VLB and ISA devices. Providing you've got a
struct device * for whatever your SATA controller is (ie a bus model of
some sort) it is sane. If you don't then you need a couple of small
patches to allow for this, or to add device model stuff to them first. I
can send you those if need be and they are in the patches but not
seperated out.



Alan

