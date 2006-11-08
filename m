Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965593AbWKHV5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965593AbWKHV5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965668AbWKHV5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:57:12 -0500
Received: from dexter.tse.gov.br ([200.252.157.99]:5806 "EHLO
	dexter.tse.gov.br") by vger.kernel.org with ESMTP id S965593AbWKHV5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:57:11 -0500
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	NOD32 for Linux Mail Server.
	For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	for Linux Server. For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
Message-ID: <4552608D.7000900@tse.gov.br>
Date: Wed, 08 Nov 2006 19:56:13 -0300
From: Saulo <slima@tse.gov.br>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE cs5530 hda: lost interrupt
References: <455254B8.4000704@tse.gov.br> <1163022263.23956.100.camel@localhost.localdomain>
In-Reply-To: <1163022263.23956.100.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried others operating systems, this machine work fine with DOS 6.22 
and Windows CE 4.2, but lock on FreeBSD and Linux.

Other strange think is that after lots and lots of "lost interrupts" 
this work. I can mount and list files but with lots of "lost interrupts" 
and after a long time.

Saulo Alessandre


Alan Cox wrote:

>Ar Mer, 2006-11-08 am 19:05 -0300, ysgrifennodd Saulo:
>  
>
>>14:          2    XT-PIC  ide0    >>> just 2 interrupts
>>15:       2964    XT-PIC  ide1
>>NMI:         0
>>ERR:         0
>>    
>>
>
>Thats very odd indeed as the IRQ is hard wired to 14. Are you sure the
>system works with other OS's and isn't faulty (I ask this as its the
>first 5530 report of this kind I've seen in about ten years, and the
>device is in legacy mode which means its hard wired to IRQ 14)
>
>Alan
>
>  
>
