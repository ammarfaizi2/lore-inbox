Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbUCHKnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 05:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbUCHKnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 05:43:23 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:46474 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262458AbUCHKnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 05:43:17 -0500
Date: Mon, 08 Mar 2004 19:46:45 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: RE: [PATCH] fix PCI interrupt setting for ia64
In-reply-to: <20040308.182552.55855095.t-kochi@bq.jp.nec.com>
To: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, benjamin.liu@intel.com
Cc: iod00d@hp.com, kaneshige.kenji@jp.fujitsu.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-id: <MDEEKOKJPMPMKGHIFAMAEEDEDGAA.kaneshige.kenji@jp.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Content-type: text/plain;	charset="us-ascii"
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Kaneshige-san, could you confirm your changes are compatible
> with probe_irq_on()?

OK. I'll confirm.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Takayoshi Kochi
> Sent: Monday, March 08, 2004 6:26 PM
> To: benjamin.liu@intel.com
> Cc: iod00d@hp.com; kaneshige.kenji@jp.fujitsu.com;
> linux-ia64@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] fix PCI interrupt setting for ia64
>
>
> Hi,
>
> From: "Liu, Benjamin" <benjamin.liu@intel.com>
> Subject: RE: [PATCH] fix PCI interrupt setting for ia64
> Date: Mon, 8 Mar 2004 15:44:16 +0800
>
> > ISA is legacy to IA64. The configuration script of 2.4.23 has
> > CONFIG_ISA off explicitly for IA64, 2.6.2 doesn't have this
> > option for IA64. I just wonder whether the legacy probing
> > method still exists on IA64.
>
> I think that's still true for IDE / serial port drivers.
> Kaneshige-san, could you confirm your changes are compatible
> with probe_irq_on()?
>
> Itanium-generation machines (such as BigSur) depends on
> probe_irq_on() for finding serial port IRQ.
>
> ---
> Takayoshi Kochi <t-kochi@bq.jp.nec.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

