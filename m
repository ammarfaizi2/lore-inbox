Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVIIIgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVIIIgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVIIIgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:36:54 -0400
Received: from imap.gmx.net ([213.165.64.20]:59030 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932534AbVIIIgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:36:53 -0400
X-Authenticated: #28678167
Message-ID: <43214A3B.8020302@gmx.net>
Date: Fri, 09 Sep 2005 10:39:23 +0200
From: Andreas Baer <lnx1@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050902)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Houston <mikeserv@bmts.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Large File Support in Kernel 2.6
References: <20050904203725.GB4715@redhat.com>	<20050902060830.84977.qmail@web50208.mail.yahoo.com>	<200509041549.17512.vda@ilport.com.ua>	<200509041144.13145.paul@misner.org>	<84144f02050904100721d3844d@mail.gmail.com>	<6880bed305090410127f82a59f@mail.gmail.com>	<20050904193350.GA3741@stusta.de>	<6880bed305090413132c37fed3@mail.gmail.com>	<20050904203725.GB4715@redhat.com>	<431F1778.5050200@tmr.com>	<5.2.1.1.2.20050907194344.00c2bea8@pop.gmx.net>	<43208B77.9060009@tmr.com>	<432090AE.2030200@gmx.net> <20050908161651.4347678c.mikeserv@bmts.com>
In-Reply-To: <20050908161651.4347678c.mikeserv@bmts.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Houston wrote:
> On Thu, 08 Sep 2005 21:27:42 +0200
> Andreas Baer <lnx1@gmx.net> wrote:
> 
> 
> 
>>I think it's 2TB for the file size and 2e73 for the file system, but
>>I don't understand the second reference and the part about the
>>CONIFG_LBD. What is exactly the CONFIG_LBD option?
>>-
> 
> 
> This is "Support for Large Block Devices" under Device Drivers/Block
> Devices:
> 
> CONFIG_LBD:
> 
> Say Y here if you want to attach large (bigger than 2TB) discs to
> your machine, or if you want to have a raid or loopback device
> bigger than 2TB.  Otherwise say N.
> 
> The "2e73" refers to 2 to the exponent 73 bytes in size. Huge :-)

So in other words, both the file size and the file system limit is 2e73
using CONFIG_LBD option, right? And 2TB are always possible?

Sorry, but I need to get pretty sure.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
