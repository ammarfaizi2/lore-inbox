Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267726AbUHMXbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267726AbUHMXbt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267737AbUHMXbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:31:49 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:50318 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S267726AbUHMXbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:31:46 -0400
Message-ID: <411D5D70.9070909@clanhk.org>
Date: Fri, 13 Aug 2004 18:31:44 -0600
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Linux SATA RAID FAQ
References: <411B0F45.8070500@pobox.com> <20040812113413.GA19252@alpha.home.local>
In-Reply-To: <20040812113413.GA19252@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:

>I like it. It's fairly simple. I'm always amazed how many people do really
>believe that these cards provide hardware RAID !!! The problem is when you
>ask a reseller to add a real hardware RAID card in a system you purchase
>and you end up with a cheap silicon image... It happened to us once and it's
>not funny at all.
>
On the brightside, md raid5 is often faster than hardware raid5.  At 
least on the 7000 and 8000 series of 3ware hardware; the 9000 series 
looks promising though.  I haven't seen megaraid SATA numbers, and I 
don't know what happened to the SX8.

When the libata Marvell drivers come out, you'll have a cheap upgrade 
path for PCI-X boards if you want fast md raid: 
http://www.supermicro.com/products/accessories/addon/DAC-SATA-MV8.cfm  
$100 to add 8 unbottlenecked SATA ports to your server motherboard.

-ryan
