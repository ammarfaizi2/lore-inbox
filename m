Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966222AbWKVEhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966222AbWKVEhp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 23:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934419AbWKVEhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 23:37:45 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:51906 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S934418AbWKVEhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 23:37:45 -0500
In-Reply-To: <1164091760.5597.18.camel@localhost.localdomain>
References: <1164081736.8207.14.camel@localhost.localdomain> <20061121064122.GA10510@kroah.com> <1164091760.5597.18.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <93B2DBD6-0E5F-485F-A785-25328271AF2D@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: bus_id collisions
Date: Tue, 21 Nov 2006 22:38:19 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.752.2)
X-PopBeforeSMTPSenders: kumar-chaos@kgala.com,kumar-statements@kgala.com,kumar@kgala.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 21, 2006, at 12:49 AM, Benjamin Herrenschmidt wrote:

>
>> Oh, that's a very annoying bus id, but I guess it's legal.
>>
>> I'll poke around and see if I can make it bigger.  You don't want it
>> bigger for static 'struct device' types, right?
>
> Don't bother too much if it's complicated. I'm trying other options as
> well, like possibly using the Open Firmware "phandle" (sort of object
> ID) which is only 32 bits, provided I can get the embedded folks to
> agree to have one at all...

Hopefully, we will not complain too much.  I can't imagine an extra  
32-bits for the two dozen or so nodes we have in a embedded tree is  
going to cause any heart burn.

- k
