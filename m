Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUGADwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUGADwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 23:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUGADwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 23:52:34 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:9640 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S263804AbUGADwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 23:52:32 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: problems with SATA: 2.6.7 working, -bk12/13/-mm4 not
Date: Thu, 1 Jul 2004 03:52:31 +0000 (UTC)
Organization: Cistron
Message-ID: <cc01pv$938$1@news.cistron.nl>
References: <cbvgor$lgp$1@news.cistron.nl> <40E34A1F.1040406@pobox.com>
X-Trace: ncc1701.cistron.net 1088653951 9320 62.216.30.38 (1 Jul 2004 03:52:31 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik  <jgarzik@pobox.com> wrote:
>Can you try:
>* disabling combined mode in BIOS

Not at this point, since it's 35 kilometers away and only linux serial
console at this moment, so no way to change the bios.

>* finding which -bk snapshot breaks your system

for i in 1 2 3 4 5
> do
> cp -a linux-2.6.7 linux-2.6.7-bk$i
> done

:-) cpu cycles put to compile ...

>* acpi=off (disabling ACPI)
>* noapic

Will do this at first compiled kernel.

>* copying the following files verbatim into your 2.6.7-{bk12,bk13,mm4} tree:
>	drivers/scsi/libata*.[ch]
>	drivers/scsi/ata_*.c
>	drivers/scsi/sata_*.[ch]
>	include/linux/libata.h
>	include/linux/ata.h

will get back.

Danny

-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -

