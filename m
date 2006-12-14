Return-Path: <linux-kernel-owner+w=401wt.eu-S1751955AbWLNSMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbWLNSMA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbWLNSMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:12:00 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55649 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751955AbWLNSL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:11:59 -0500
Date: Thu, 14 Dec 2006 18:20:10 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata-pata with ICH4, rootfs
Message-ID: <20061214182010.477073a9@localhost.localdomain>
In-Reply-To: <200612141714.55948.s0348365@sms.ed.ac.uk>
References: <200612141714.55948.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 17:14:55 +0000
Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Hi Alan,
> 
> Is it possible to use pata_mpiix (or pata_oldpiix) with an ICH4 IDE controller 
> and boot off it?

ata_piix (the SATA/PATA driver) deals with the ICH4. pata_mpiix is
specifically for the Intel MPIIX laptop chipset and pata_oldpiix
explicitly for the original PIIX chipset and none of the later ones.

