Return-Path: <linux-kernel-owner+w=401wt.eu-S964868AbWL1CMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWL1CMv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 21:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWL1CMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 21:12:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:48304 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964868AbWL1CMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 21:12:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eDXXK5EO6kluq6gWeS4a763KrAROfPobgJ+4LybRp8UHJ/IwTApLtwUx5Lmo44XaxzitcsNEXVQgrXvTeAbInBDyNYsKHXDS86fBq05FCtp3i+ZGfKbNOOjPqSCwNI9XJfkqEZzH2RZO8bTAH4p3zAOUgYIGa7TQOyVKoVzKSBg=
Message-ID: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com>
Date: Thu, 28 Dec 2006 02:12:48 +0000
From: "Andrew Lyon" <andrew.lyon@gmail.com>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0) r0xj0
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My system is gigabyte ds3 motherboard with onboard SATA JMicron
20360/20363 AHCI Controller (rev 02), drive connected is WDC
WD740ADFD-00 20.0, I am running 2.6.18.6 32 bit, under heavy i/o I get
the following messaegs:

ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)

Is this condition dangerous?

I plan to upgrade to 2.6.19 soon as I have problems with a sata dvd
writer but I have to wait for a driver that I need to catch up, this
system cannot be down for long as it runs mythtv.

Andy
