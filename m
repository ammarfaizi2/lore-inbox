Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965382AbWKIMbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965382AbWKIMbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 07:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbWKIMbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 07:31:31 -0500
Received: from dexter.tse.gov.br ([200.252.157.99]:34500 "EHLO
	dexter.tse.gov.br") by vger.kernel.org with ESMTP id S932818AbWKIMba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 07:31:30 -0500
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	NOD32 for Linux Mail Server.
	For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	for Linux Server. For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
Message-ID: <45532D7E.6050606@tse.gov.br>
Date: Thu, 09 Nov 2006 10:30:38 -0300
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

Alan Cox wrote:

>Ar Mer, 2006-11-08 am 19:48 -0300, ysgrifennodd Saulo:
>  
>
>>I tried others operating systems, this machine work fine with DOS 6.22
>>and Windows CE 4.2, but lock on FreeBSD and Linux.
>>    
>>
>
>So it works with systems that don't use the interrupt ? Is this some
>kind of PDA type device designed for Windows CE where they've not
>bothered wiring the interrupt perhaps.
>
>If so you'll need to write a polling CF driver for it, which actually is
>one of those things that we could do with for some other embedded cases
>too.
>
>Alan
>
No it's not a PDA designed for Windows CE it´s a motherboard designed 
for us like 386 compatible. According to motherboard´s designers INTR 
are standard and Windows XP run too without any changes.

Saulo
