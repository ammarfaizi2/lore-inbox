Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbVA2HWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVA2HWt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 02:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVA2HWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 02:22:49 -0500
Received: from web52205.mail.yahoo.com ([206.190.39.87]:15027 "HELO
	web52205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262870AbVA2HWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 02:22:47 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=nCAszNmGX7ufzt+ZXMxdszgmUOHsByMM5ygCvtP8D820ZV8CeZpgmyTl1yUlzkVMhxq7cr2tvKKNhbhF2mM5OfBowcK37zII880geH3zUnXhrLPmM77nWHS4vF8oJHTAakOlvyxlU41rnjiRneDAka4Hm3wAls1Va64lg2NV2js=  ;
Message-ID: <20050129072247.65074.qmail@web52205.mail.yahoo.com>
Date: Fri, 28 Jan 2005 23:22:47 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: help me to know when ethernet header added to packet by eth_header function
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
      Can anybody explain me how ethernet header is
added to every packet outgoing? I check eth.c file and
found eth_header that is used for adding ethernet
header on skbuff packet. But does each packet calls
this function? I think not as theres a cache header
function used that cache ethernet header entry.
      So my main question is that when my machine
first contacted to any other pc in LAN does it calls
eth_header and when require to send any type of packet
to same machine i thnik eth_cache_header is used is
that right???
      Then can it be possible that if my machine not
contacted to any cached entry machine then eth_header
will be called again to build eth header for that
machine?
      In an all when functions in eth.c will be
called/not called
eth_header,eth_header_cache,eth_header_parse,eth_header_cache_update???
      Please kindly help me to identify it.
Thanks in advance.
regards,
linux_lover.


	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail
