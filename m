Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269281AbTCBT06>; Sun, 2 Mar 2003 14:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269282AbTCBT06>; Sun, 2 Mar 2003 14:26:58 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:4796 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S269281AbTCBT05>; Sun, 2 Mar 2003 14:26:57 -0500
Message-ID: <3E625D76.8050503@sixbit.org>
Date: Sun, 02 Mar 2003 14:37:26 -0500
From: John Weber <weber@sixbit.org>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Dominik Brodowski <linux@brodo.de>, linux-kernel@vger.kernel.org
Subject: Re: [UPDATED PATCH] pcmcia: add bus_type pcmcia_bus_type, struct
 pcmcia_driver
References: <20030301213328.GA4480@brodo.de>
In-Reply-To: <20030301213328.GA4480@brodo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> This patch adds a new bus_type pcmcia_bus_type, and registers all pcmcia
> drivers with this bus within the old register_pccard_driver()
> function. 
> 
> Alternatively, a new registration function "pcmcia_register_driver()"
> (and its counterpart,  "pcmcia_unregister_driver()") can be used --
> the pcnet_cs.c driver is converted as an example.
> 
> This updated version fixes the compilation breakage seen with gcc-2.95.3
> because of incompatible C99 initializers (sorry, Russell). 

I've applied this patch, and have run the kernel for a few days without 
problems.

Do you have an example driver ported to this new api?  I can help 
convert drivers.

