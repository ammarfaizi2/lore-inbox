Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUIPBRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUIPBRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 21:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUIPBPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 21:15:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267400AbUIOU0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:26:20 -0400
Message-ID: <4148A561.5070401@redhat.com>
Date: Wed, 15 Sep 2004 16:26:09 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
CC: Netdev <netdev@oss.sgi.com>, leonid.grossman@s2io.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
References: <4148991B.9050200@pobox.com> <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:
> On Wed, 15 Sep 2004, Jeff Garzik wrote:
> 
>> Put simply, the "ultimate TOE card" would be a card with network 
>> ports, a generic CPU (arm, mips, whatever.), some RAM, and some 
>> flash.  This card's "firmware" is the Linux kernel, configured to run 
>> as a _totally indepenent network node_, with IP address(es) all its own.
>>
>> Then, your host system OS will communicate with the Linux kernel 
>> running on the card across the PCI bus, using IP packets (64K fixed MTU).
> 
> 
>> My dream is that some vendor will come along and implement such a 
>> design, and sell it in enough volume that it's US$100 or less. There 
>> are a few cards on the market already where implementing this design 
>> _may_ be possible, but they are all fairly expensive.
> 
> 
> The intel IXP's are like the above, XScale+extra-bits host-on-a-PCI card 
> running Linux. Or is that what you were referring to with "<cards exist> 
> but they are all fairly expensive."?
> 
>>     Jeff
> 
> 
> regards,

IBM's PowerNP chip was also very simmilar (a powerpc core with lots of 
hardware assists for DMA and packet inspection in the extended register 
area).  Don't know if they still sell it, but at one time I had heard 
they had booted linux on it.
Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
