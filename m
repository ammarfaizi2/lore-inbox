Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312403AbSC3HkG>; Sat, 30 Mar 2002 02:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312408AbSC3Hj4>; Sat, 30 Mar 2002 02:39:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13329 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312403AbSC3Hjr>;
	Sat, 30 Mar 2002 02:39:47 -0500
Message-ID: <3CA56B5E.7030508@mandrakesoft.com>
Date: Sat, 30 Mar 2002 02:38:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david+cert@blue-labs.org>
CC: Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org
Subject: Re: tulip driver again
In-Reply-To: <20020328174724.A24374@mail.harddata.com> <3CA50662.6090709@blue-labs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:

> "Me too" however I managed to get mine to work by swaping PCI cards 
> in/out and doing power off reboots.  It is working on this particular 
> boot up so I'm leaving it running.
>
> Jeff Garzik, if you want the lspci, register dump, etc, please speak up.


Yes, please do.

The more bug reports I can receive (in private or CC'd to lkml), the 
better picture I get.  If you have multiple tulips, feel free to email 
reports on those too :)

Best output is:
    lspci -vvvn
    dmesg, after updating drivers/net/tulip/tulip.h TULIP_DEBUG to 5, 
and recompiling
    tulip-diag -mmaavvveef

tulip-diag was written by Donald Becker, and is available from 
ftp://www.scyld.com/pub/diag/  Compiling instructions are at the end of 
tulip-diag.c.  You should grab libmii.c as well.

    Jeff




