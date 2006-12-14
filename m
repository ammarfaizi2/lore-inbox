Return-Path: <linux-kernel-owner+w=401wt.eu-S932866AbWLNSch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbWLNSch (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932887AbWLNSch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:32:37 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:4524 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932866AbWLNScg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:32:36 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-pata with ICH4, rootfs
Date: Thu, 14 Dec 2006 18:32:50 +0000
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200612141714.55948.s0348365@sms.ed.ac.uk> <20061214182010.477073a9@localhost.localdomain>
In-Reply-To: <20061214182010.477073a9@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612141832.50587.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 December 2006 18:20, Alan wrote:
> On Thu, 14 Dec 2006 17:14:55 +0000
>
> Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > Hi Alan,
> >
> > Is it possible to use pata_mpiix (or pata_oldpiix) with an ICH4 IDE
> > controller and boot off it?
>
> ata_piix (the SATA/PATA driver) deals with the ICH4. pata_mpiix is
> specifically for the Intel MPIIX laptop chipset and pata_oldpiix
> explicitly for the original PIIX chipset and none of the later ones.

Correct me if I'm wrong, but SATA wasn't available on ICH4. Only 5 and 
greater. The kernel help text agrees with me.

My IDE controller usually works with CONFIG_BLK_DEV_PIIX; I was interested in 
using your pata_xxx drivers in replacement, assuming there was support.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
