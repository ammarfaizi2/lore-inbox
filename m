Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVIWJru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVIWJru (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 05:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVIWJru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 05:47:50 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:26049 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750860AbVIWJrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 05:47:49 -0400
Message-ID: <4333CF4C.2000306@anagramm.de>
Date: Fri, 23 Sep 2005 11:47:56 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Sanchez <david.sanchez@lexbox.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to Force PIO mode on sata promise (Linux 2.6.10)
References: <17AB476A04B7C842887E0EB1F268111E026FC5@xpserver.intra.lexbox.org>
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E026FC5@xpserver.intra.lexbox.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David!

David Sanchez wrote:
> I've reduced the UDMA level step by step until the problem seems disappeared.
> Finally with UDMA/25 I don't detect error after 1000 copies. I consider that this solution corrects the symptom but not the cause...

Hmm, no luck for you, today?
Have you possibilities to check the signal integrity in your design?
Did you play some of the electrical engineering tricks to see if things
are changing? (change some terminations, temperature, voltages)

> My embedded system:
> 	* AMD Development Board AU1550 (mips32) + hdd connected to the pata port of the Promise PDC20579 controller.
> 	* Kernel2.6.10 + libata patch + busybox 1.0

Well, what about getting a datasheet of the PDC, one of the latest kernels and
start to debug that thing down to the silicon?

There is a person called Ed Huang (Sales and Marketing Div.) at Promise
in Taiwan where we got our datasheets and reference designs for our embedded
project. Unfortunately, you need to sign a NDA. But beside that, the support
is pretty okay. (I just send you the contact in private email).

Best greets,

-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
