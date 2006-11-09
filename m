Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424140AbWKIVVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424140AbWKIVVa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424150AbWKIVVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:21:30 -0500
Received: from retort.sout.netline.net.uk ([213.40.66.77]:37879 "EHLO
	retort.sout.netline.net.uk") by vger.kernel.org with ESMTP
	id S1424140AbWKIVV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:21:29 -0500
Message-ID: <45539BD3.10402@supanet.com>
Date: Thu, 09 Nov 2006 21:21:23 +0000
From: Andrew Benton <b3nt@supanet.com>
User-Agent: Thunderbird 3.0a1 (X11/20061109)
MIME-Version: 1.0
To: Ping Cheng <pingc@wacom.com>
CC: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Typo in drivers/usb/input/wacom_wac.c?
References: <6753EB6004AFF34FAA275742C104F95201758D@wacom-nt10.wacom.com>
In-Reply-To: <6753EB6004AFF34FAA275742C104F95201758D@wacom-nt10.wacom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Supanet-AV-out: Mail Scanned as virus free, although you should still use a local virus scanner.
X-Supanet: This was sent via a www.supanet.com mail server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ping Cheng wrote:
> The two wacom_be16_to_cpu are in wacom_intuos_irq, which has nothing to do with Volito2. Volito2 uses wacom_graphire_irq. I am not exactly sure what Andrew's problem is. 

The problem is that the wacom kernel driver in the 2.6.19-rc5 kernel 
doesn't work with my Volito 2 tablet. The cursor stays in the bottom 
right hand corner of the screen and only responds to me moving the pen 
by jittering about a bit.
 From what you said it seems that the kernel wacom driver treats my 
volito2 as though it's an intuos. The kernel correctly identifies it as 
a volito 2 in the system log but if I don't apply that sed to the source 
before I compile the kernel the tablet doesn't work.

Andy
