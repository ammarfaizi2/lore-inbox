Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030631AbVIBBdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030631AbVIBBdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030639AbVIBBdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:33:22 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:52055 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1030631AbVIBBdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:33:21 -0400
Message-ID: <4317ABC0.3040603@emc.com>
Date: Thu, 01 Sep 2005 21:32:48 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com> <20050901144038.GA25830@infradead.org> <20050901222617.2455520F96@lns1058.lss.emc.com>
In-Reply-To: <20050901222617.2455520F96@lns1058.lss.emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.1.35
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> This is my libata compatible low level driver for the Marvell SATA
> family.  Currently it successfully runs in PIO mode on a 6081 chip.
> EDMA support is in the works and should be done shortly.  Review,
> testing (especially on other flavors of Marvell), comments welcome.

Note that this patch depends on the PCI INTx patch I submitted earlier:

http://lkml.org/lkml/2005/8/15/165

Sorry for the delayed notice,
BR
