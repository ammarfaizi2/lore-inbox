Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbUAaSSK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 13:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbUAaSRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 13:17:46 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:10923 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265056AbUAaSRL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 13:17:11 -0500
Message-ID: <401BF122.2090709@blue-labs.org>
Date: Sat, 31 Jan 2004 13:17:06 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jens Axboe <axboe@suse.de>, Mans Matulewicz <cybermans@xs4all.nl>
Subject: Re: ide-cdrom / atapi burning bug - 2.6.1
References: <1075511134.5412.59.camel@localhost> <20040131093438.GS11683@suse.de>
In-Reply-To: <20040131093438.GS11683@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have an RW, but when my cdrom fixates, it stalls everything 
while it's fixating.  I have an nForce chipset.  (2.6.x)

Jens Axboe wrote:

>On Sat, Jan 31 2004, Mans Matulewicz wrote:
>  
>
>>Hi,
>>After replacing my 2.4.22  with a 2.6.1 kernel I tried ATAPI cd burning.
>>This totally fails. Most of the CD's are corrupt and my system totally
>>locks up when erasing an cdrw (reset button was the option I needed to
>>reboot my system) . k3b reports cd is completely burned but fails are
>>not identical or totally unreadable. I tried it both with an tainted
>>(nvidia) and an untainted (nv) kernel: same results. With ide-scsi
>>burning in 2.4.x I had no problems. 
>>    
>>
>
>Did you use DMA in 2.4 as well? Does 2.6 work if you turn it off? It's
>most likely an issue with your via adapter.
>
>  
>
