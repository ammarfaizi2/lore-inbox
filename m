Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUGAIyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUGAIyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 04:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbUGAIyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 04:54:12 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:64937 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S264371AbUGAIyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 04:54:06 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: problems with SATA: 2.6.7 working, -bk12/13/-mm4 not
Date: Thu, 1 Jul 2004 08:54:05 +0000 (UTC)
Organization: Cistron
Message-ID: <cc0jfd$smu$1@news.cistron.nl>
References: <cbvgor$lgp$1@news.cistron.nl> <40E34A1F.1040406@pobox.com>
X-Trace: ncc1701.cistron.net 1088672045 29406 62.216.30.38 (1 Jul 2004 08:54:05 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik  <jgarzik@pobox.com> wrote:
>* disabling combined mode in BIOS

No bios acces for another month at least.

>* finding which -bk snapshot breaks your system

bk5 = fine
bk6 breaks 

>* acpi=off (disabling ACPI)

bk6, bk12, bk13, mm4 suddenly work with acpi=off 

>* noapic

doesn't work

>* copying the following files verbatim into your 2.6.7-{bk12,bk13,mm4} tree:
>	drivers/scsi/libata*.[ch]
>	drivers/scsi/ata_*.c
>	drivers/scsi/sata_*.[ch]
>	include/linux/libata.h
>	include/linux/ata.h

this indeed "fixes" it.
I have a working 2.6.7-bk13a with above files from vanilla-2.6.7

Hope this feedback helps.

Danny

-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -

