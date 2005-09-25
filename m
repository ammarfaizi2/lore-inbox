Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVIYHk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVIYHk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 03:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVIYHk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 03:40:26 -0400
Received: from web35906.mail.mud.yahoo.com ([66.163.179.190]:37247 "HELO
	web35906.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751233AbVIYHkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 03:40:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0v6cEqMzLKD7MN6c6IPUra6hFEZ8YYnNWSnxZVM8sgaN/fly75vU/JxVg76Nr8ihso/B0e7vPfkFqbOQmHYwjTGayb/f5TCDKvEAsCRVSW6czJGro+Slf33bkjtrPOCzp4ZjcAfgEt6bjA/MXP5VWg4PMjHRYPT6cYW3jPwHaE0=  ;
Message-ID: <20050925074021.20942.qmail@web35906.mail.mud.yahoo.com>
Date: Sun, 25 Sep 2005 00:40:20 -0700 (PDT)
From: umesh chandak <chandak_pict@yahoo.com>
Subject: problem regarding new LSM hook
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello sir,

		I am using madwifi v1.5 driver with linksys pci
adapter.


I have written a lsm hook  for netif_rx(struct sk_buff
*skb) in security.h file. 
I have  called that hook from  netif_rx fuction (after
variable declaration) in net/core/dev.c . 


Then I have written module for that hook.In that
module, I have dropped Icmp packets. But in Wireless
network ,When i ping machine "B" from machine "A" ,i
am getting the message on console like this
  64 bytes from machine "B" ip addr :icmp_seq=no
......   
but this should not happen because i am dropping
incoming Icmp packets in my module.
Can you tell me why this is happening.What i have made
wrong .
          

Note :    1)My module is working proper and i have
also
              freed the skb buffer.
	  2)It work fine for wired network.
	  3)Ethereal shows the correct result (does not
capture ICMP reply packets)
            for both wired and wireless network.


                          -Plz help me.We are trying
this from 6 days .  	                   
            thanks in advance
-Rishi


	
		
______________________________________________________ 
Yahoo! for Good 
Donate to the Hurricane Katrina relief effort. 
http://store.yahoo.com/redcross-donate3/ 

