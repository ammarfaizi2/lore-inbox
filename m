Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272418AbTGaJEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 05:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272427AbTGaJEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 05:04:33 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:48788 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S272418AbTGaJEa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:04:30 -0400
From: "Nicolas P." <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: Re: wireless MA401 RequestIRQ: Resource in use
Date: Thu, 31 Jul 2003 11:05:13 +0200
User-Agent: KMail/1.5
References: <200307311021.35169.linux@1g6.biz>
In-Reply-To: <200307311021.35169.linux@1g6.biz>
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307311105.13509.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, I found myself,

switched on ISA support corrected the problem,
dont know why but it works.
(pcmcia card ...)

Nicolas.

Le Jeudi 31 Juillet 2003 10:21, Nicolas P. a écrit :
> Hi,
>
> I have bought an MA401 netgear 802.11b network adapter,
> it works well with 2.4.x kernel,
> but there seems to be a problem with 2.6 kernels,
> I tested 2 differents drivers with same result : "RequestIRQ: Resource in
> use" With acpi on toshiba tecra 8100.
>
> Regards.
>
> Nicolas.
>
> First standard kernel driver :
>
> orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> orinoco_cs: RequestIRQ: Resource in use
>
> Second hostap driver :
>
> hostap_crypt: registered algorithm 'NULL'
> hostap_cs: no version for "CardServices" found: kernel tainted.
> hostap_cs: 0.0.4 - 2003-07-27 (Jouni Malinen <jkmaline@cc.hut.fi>)
> hostap_cs: setting Vcc=33 (constant)
> hostap_cs: CS_EVENT_CARD_INSERTION
> prism2_config()
> hostap_cs: setting Vcc=50 (from config)
> Checking CFTABLE_ENTRY 0x01 (default 0x01)
> IO window settings: cfg->io.nwin=1 dflt.io.nwin=1
> io->flags = 0x0046, io.base=0x0000, len=64
> hostap_cs: RequestIRQ: Resource in use
> prism2_release
>
> : card already removed or not configured during shutdown
>
> release - done
> prism2_detach
> hostap_free_data: ap has not yet been initialized - skip resource freeing
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

