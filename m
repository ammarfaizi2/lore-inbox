Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266827AbUHCUlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266827AbUHCUlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266770AbUHCUlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:41:51 -0400
Received: from s124.mittwaldmedien.de ([62.216.178.24]:44758 "EHLO
	s124.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S266833AbUHCUlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:41:50 -0400
Message-ID: <410FF899.1070007@vcd-berlin.de>
Date: Tue, 03 Aug 2004 22:42:01 +0200
From: Elmar Hinz <elmar.hinz@vcd-berlin.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Add support for IT8212 IDE controllers
References: <2obsK-5Ni-13@gated-at.bofh.it> <410F7407.8070903@vcd-berlin.de> <1091530208.3573.5.camel@localhost.localdomain> <410F828E.3090808@vcd-berlin.de>
In-Reply-To: <410F828E.3090808@vcd-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Not your fault - I missed out an include file update when I posted it -
>> PCI_DEVICE_ID_ITE_8212 is 0x8212..
>>

This seems to mean:

put this

#define PCI_DEVICE_ID_ITE_8212             0x8212

into that

/usr/src/kernel-source-2.x.x/include/linux/pci_ids.h

Regards

Elmar

