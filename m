Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946020AbWKJIS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946020AbWKJIS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424381AbWKJIS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:18:27 -0500
Received: from kilderkin.sout.netline.net.uk ([213.40.66.40]:12241 "EHLO
	kilderkin.sout.netline.net.uk") by vger.kernel.org with ESMTP
	id S1424380AbWKJIS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:18:26 -0500
Message-ID: <455435CE.1040200@supanet.com>
Date: Fri, 10 Nov 2006 08:18:22 +0000
From: Andrew Benton <b3nt@supanet.com>
User-Agent: Thunderbird 3.0a1 (X11/20061109)
MIME-Version: 1.0
To: Ping Cheng <pingc@wacom.com>
CC: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Typo in drivers/usb/input/wacom_wac.c?
References: <6753EB6004AFF34FAA275742C104F952017590@wacom-nt10.wacom.com>
In-Reply-To: <6753EB6004AFF34FAA275742C104F952017590@wacom-nt10.wacom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Supanet-AV-out: Mail Scanned as virus free, although you should still use a local virus scanner.
X-Supanet: This was sent via a www.supanet.com mail server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ping Cheng wrote:
> Yes, I understand your Volito2 doesn't work. I guess I should phase my sentence as:
> 
> I am not exactly sure what THE ROOT CAUSE of your problem is.  Volito and Volito2 have had issues with the statement 
> 
> if (data[0] == 99) return; 
> 
> in wacom_graphire_irq for a while. Some users said they have to have that line.  But more users said that line should not be there. 
> 
> The current version of wacom_wac.c doesn't have it (it was there in previous versions).
> 
> Andy, let's talk about it offline to figure out your problem.  
> 
> Ping
> 
> -----Original Message-----
> From: Andrew Benton [mailto:b3nt@supanet.com]
> Sent: Thursday, November 09, 2006 1:21 PM
> To: Ping Cheng
> Cc: Greg KH; Linux Kernel Mailing List
> Subject: Re: Typo in drivers/usb/input/wacom_wac.c?
> 
> 
> Ping Cheng wrote:
>> The two wacom_be16_to_cpu are in wacom_intuos_irq, which has nothing to do with Volito2. Volito2 uses wacom_graphire_irq. I am not exactly sure what Andrew's problem is. 

User error. This entire thread was based on a mistake. Sorry for wasting 
your time.

Andy
