Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTIOXUW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTIOXUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:20:21 -0400
Received: from nelson.SEDSystems.ca ([192.107.131.136]:36843 "EHLO
	nelson.sedsystems.ca") by vger.kernel.org with ESMTP
	id S261723AbTIOXUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:20:13 -0400
Message-ID: <3F6649A1.6070103@sedsystems.ca>
Date: Mon, 15 Sep 2003 17:22:09 -0600
From: Kendrick Hamilton <hamilton@sedsystems.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI probe, please CC hamilton@sedsystems.ca
References: <3F66441F.3010206@sedsystems.ca> <20030915230949.GA18153@kroah.com>
In-Reply-To: <20030915230949.GA18153@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,
    We don't have a hardware address to use. What I am looking for is a 
way to tie it to the slot number. Is there any way of getting the slot 
number?
Kendrick

PS. I just subscribed to the linux kernel mailing list so I don't need 
the CC hamilton@sedsystems.ca anymore.


Greg KH wrote:

>On Mon, Sep 15, 2003 at 04:58:39PM -0600, Kendrick Hamilton wrote:
>  
>
>>Hello,
>>   we are using the Linux 2.2.16 kernel (some of the code we purchased 
>>does not work with 2.4.x kernels and we would have to do a lot of 
>>regression testing to upgrade) on an IBM e-server. We wrote a module for 
>>a modulator card we are using. The code uses pci_find_device to find the 
>>modulator cards. The problem we are having is that it finds the cards in 
>>different orders. One time hss0 is the card in slot 4 and hss1 is the 
>>card in slot5. The next time we power up the computer, hss0 is the card 
>>in slot5 and hss1 is the card in slot 4.
>>   The IBM e-server has about 5 PCI bridges.
>>   Do you have any suggestion as to how I might be able to ensure the 
>>cards are always detected in the same order? Our system requires that 
>>they always be in the same order.
>>    
>>
>
>Are the pci device ids different across different boots?  If not, is
>there any way you can tie a specific device to a specific interface
>(unique hardware addresses, mac addresses, etc.)?
>
>thanks,
>
>greg k-h
>  
>

