Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVDBHmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVDBHmk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 02:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVDBHmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 02:42:40 -0500
Received: from smtp1.poczta.interia.pl ([217.74.65.44]:46941 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261194AbVDBHmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 02:42:37 -0500
Message-ID: <424E4CE8.4070702@interia.pl>
Date: Sat, 02 Apr 2005 09:42:32 +0200
From: Marcin Glogowski <marcin.glogowski@interia.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ioremap - simply question, big problem (to me)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: e0940acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I have several questions about ioremap:

1) I have two 16 bit sram memory devices. To force it works I had to use 
ioremap with memorysize*2, because
I was able to write to the 1 and 2 byte, 5,6, 9,10, 13,14 and so on.
Please explain why my ioremap space is non-continous,
how to ioremap a 32 bit device that consists of 2 16 bit devices? (in 
another system I simply copied the 16 bits to first device and another 
16 bits
to the second device and I had a working system) and why in the remapped 
memory are holes?

2) In my another system to get a value of the register from a flash 
device I had to use "volatile u16 the_address_of_my_device".
How to get the value in the case when Linux has virtual remapped the 
physical address?

Thank you.

----------------------------------------------------------------------
Startuj z INTERIA.PL! >>> http://link.interia.pl/f186c 

