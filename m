Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUJLOhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUJLOhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUJLOgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:36:20 -0400
Received: from foss.kharkov.ua ([195.69.184.25]:23700 "EHLO
	relay.foss.kharkov.ua") by vger.kernel.org with ESMTP
	id S264704AbUJLOd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:33:56 -0400
X-AV-Checked: Tue Oct 12 17:33:22 2004 passed
Message-ID: <416BEB59.5010809@kharkiv.com.ua>
Date: Tue, 12 Oct 2004 17:34:01 +0300
From: Oleksiy <Oleksiy@kharkiv.com.ua>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
References: <416A6CF8.5050106@kharkiv.com.ua> <20041011113609.GB417@logos.cnet>
In-Reply-To: <20041011113609.GB417@logos.cnet>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No, i haven't changed anything: the same cable, the same modules.
I was compiling new kernels (-pre1, -pre2 ... all patches ) and just 
after boot running pppd to test connection.
2.4.26 and all 2.4.27-preX works fine till -pre6. All after -pre6 
including 2.4.28-pre4 are not working for me...

Hardware: Dell Inspiron 1100 notebook

Marcelo Tosatti wrote:

>Pete, 
>
>I bet this has been caused by your USB changes?
>
>Can you take a look at this please?
>
>On Mon, Oct 11, 2004 at 02:22:32PM +0300, Oleksiy wrote:
>  
>
>>Hi all,
>>
>>I have a problem using GPRS inet vi my Siemens S55 attached with USB 
>>cable since kernel version 2.4.27-pre5, the link is established well, 
>>but then no packets get received, looking with tcpdump shows outgoing 
>>ping packets and just few per several minutes received back. I'm unable 
>>to ping, do nslookup, etc.
>>The problem started when i switched from kernel 2.4.26 (linux slackware 
>>10.0) to 2.4.28-pre3. None of ppp otions haven't changed and all the 
>>same options were set during kerenel config. So i decided to test all 
>>kernels between 2.4.26 and 2.4.28-pre4 (also not working). Link works 
>>well in 2.4.27-pre5 and stop working in 2.4.27-pre6. No "strange" 
>>messages or errors in the logs. firewall is disabled (ACCEPT for all).
>>
>>i'm using:
>>
>>pppd-2.4.2
>>Siemens S55 mobile
>>USB cable (PL2303 conroller)
>>
>>USB drivers:
>>
>>ehci_hcd
>>uhci.c
>>pl2303.c
>>
>>    
>>

-- 
Oleksiy
http://voodoo.com.ua

