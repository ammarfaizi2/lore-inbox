Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUFCKFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUFCKFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 06:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUFCKFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 06:05:37 -0400
Received: from dialpool3-11.dial.tijd.com ([62.112.12.11]:12928 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S263088AbUFCKFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 06:05:22 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] ICH5 SATA problems
Date: Thu, 3 Jun 2004 12:05:11 +0200
User-Agent: KMail/1.6.2
Cc: Erik Steffl <steffl@bigfoot.com>
References: <200406030642.16890.lkml@kcore.org> <40BEC11F.8070605@bigfoot.com>
In-Reply-To: <40BEC11F.8070605@bigfoot.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406031205.12426.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 08:11, Erik Steffl wrote:
> Jan De Luyck wrote:
> > Hello List,
> >
> > A friend of mine is trying to get both SATA and PATA working together on
> > his Siemens box. The bios has a bunch of settings concering sata/pata,
> > being:
> > - SATA Standard (which is bootable by the bios). When this is selected,
> > another setting is available * Sata 1/2 only
> > 	* sata 1/2 + pata 3/4
> > 	* pata 1/2 + sata 1/2
>
>    which kernel are you using and what are the sata related settings?

The kernel involved is 2.6.6 (as noted in the subject), vanilla.
>
>    I have intel D865PERL with same sata controller as your friend, using
> kernel 2.6.5, sata configured as scsi:
>
> CONFIG_SCSI=y
> CONFIG_SCSI_SATA=y
> CONFIG_SCSI_ATA_PIIX=y

Same configuration options are on.

>    with 2.4.x kernels you might need some patches, the first 2.4.x
> kernel  I know supports SATA is 2.4.21-ac4, plus you (your friend) need
> libata5 patches for SATA disks over 137GB.

He's going to insert 200gb maxtor drives - is this patch needed for 2.6.6 too?

Thx.

Jan

-- 
Reality is for people who lack imagination.
