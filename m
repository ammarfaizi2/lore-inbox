Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTAYTct>; Sat, 25 Jan 2003 14:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbTAYTct>; Sat, 25 Jan 2003 14:32:49 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:61854 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261855AbTAYTct>;
	Sat, 25 Jan 2003 14:32:49 -0500
Message-ID: <3E32E87F.7080909@colorfullife.com>
Date: Sat, 25 Jan 2003 20:41:51 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: AnonimoVeneziano <voloterreno@tin.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Probably buggy MP Table and ACPI doesn't works
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which problems do you have at runtime? Do all ide disk work?

I.e. do you have problems with ide, or is the reporting wrong?
Legacy ide always uses irq 14 and 15, it could be overeager error 
detection that notices that unused fields in the pci configuration data 
contain odd values.

Could you add lspci -vxxx -s 00:11.1?

--
    Manfred



