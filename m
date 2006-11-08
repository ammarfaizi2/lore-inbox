Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161734AbWKHWSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161734AbWKHWSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbWKHWSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:18:00 -0500
Received: from dexter.tse.gov.br ([200.252.157.99]:59322 "EHLO
	dexter.tse.gov.br") by vger.kernel.org with ESMTP id S1161734AbWKHWR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:17:58 -0500
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	NOD32 for Linux Mail Server.
	For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	for Linux Server. For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
Message-ID: <4552656C.9090807@tse.gov.br>
Date: Wed, 08 Nov 2006 20:17:00 -0300
From: Saulo <slima@tse.gov.br>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE cs5530 hda: lost interrupt
References: <455254B8.4000704@tse.gov.br>	 <1163022263.23956.100.camel@localhost.localdomain>	 <45525EB0.1070907@tse.gov.br> <1163023173.23956.111.camel@localhost.localdomain>
In-Reply-To: <1163023173.23956.111.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other strange think is that after lots and lots of "lost interrupts" 
this work. I can mount and list files but with lots of "lost interrupts" 
and after a long time.

this is the strange.

before ls in primary master

14:          2    XT-PIC  ide0    >>> just 2 interrupts
15:       3893    XT-PIC  ide1

after ls and many "lost interrupts"

14:          2    XT-PIC  ide0    >>> just 2 interrupts
15:       3901    XT-PIC  ide1    >>> more interrupts


[]´s Saulo Alessandre

