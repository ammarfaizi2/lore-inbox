Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbUAMTG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbUAMTG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:06:57 -0500
Received: from pop.gmx.de ([213.165.64.20]:59554 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265501AbUAMTGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:06:41 -0500
X-Authenticated: #4512188
Message-ID: <400441BD.9020609@gmx.de>
Date: Tue, 13 Jan 2004 20:06:37 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm2
References: <20040110014542.2acdb968.akpm@osdl.org>	<4003F34E.5080508@gmx.de> <20040113095428.440762f7.akpm@osdl.org>
In-Reply-To: <20040113095428.440762f7.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:
> 
>>Hi,
>>
>>mm2 (or even mm1 or even vanilla, have not tested (long enough)) locks 
>>hard on my and someone else' machine. Sometimes we get this line in our 
>>logs before the lock happens:
>>
>>kernel: Badness in pci_find_subsys at drivers/pci/search.c:132
>>
>>Any ideas? Or do you need detailed kernel config and dmesg? I thought 
>>you might have an idea which atch caused this... My and his system are 
>>quite differnt. Major Common element seems only use of Athlon XP. He has 
>>VIA KT based system and I have nforce2. I thought it might be APIC, but 
>>I also got a lock up without APIC. (Though it seems more stable without 
>>APIC.)
> 
> 
> If you could send us the stack backtrace that would help.  Make sure that
> you have CONFIG_KALLSYMS enabled.  If you have to type it by hand, just the
> symbol names will suffice - leave out the hex numbers.

Sorry, I am a noob about such things. Above option is enabled in my 
config, but I dunno how get the stack backtrace. Could you point to me 
to something helpful?
BTW, today the kernel didn't lock up. (But I didn't have the machine on 
the whole day.) Perhaps it will when I put in APIC  again. Was anything 
changed there recently?

Prakash
