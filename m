Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265135AbUFWPuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbUFWPuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUFWPuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:50:39 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8613 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265135AbUFWPuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:50:37 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Anssi Saari <as@sci.fi>
Subject: Re: PROBLEM: booting 2.6.7 hangs with IRQ handling problems
Date: Wed, 23 Jun 2004 17:48:33 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <20040622192942.GA15367@sci.fi>
In-Reply-To: <20040622192942.GA15367@sci.fi>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406231748.33679.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 of June 2004 21:29, Anssi Saari wrote:
> 
> Hello,

Hi,

> On my home PC I have an AMD Athlon XP 1900+ on an Aopen AK77-600Max
> motherboard, VIA KT600 chipset. It works fine with Linux 2.6.6, apart
> from the apparently nonexistent support for PATA devices on the Promise
> PDC20378, but I can't boot 2.6.7. I've tried vanilla 2.6.7, 2.6.7 with
> acpi-20040326 patch and 2.6.7-bk4. acpi=off, noapic or nolapic don't
> seem to help.

Since 2.6.6 works and 2.6.7-bk4 doesn't can you try -bk1/2/3 and
do bisection search on specific changesets?  Thanks!

Bartlomiej
