Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271449AbRHOVVr>; Wed, 15 Aug 2001 17:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271458AbRHOVVh>; Wed, 15 Aug 2001 17:21:37 -0400
Received: from mail.erisksecurity.com ([208.179.59.234]:56364 "EHLO
	Tidal.eRiskSecurity.com") by vger.kernel.org with ESMTP
	id <S271449AbRHOVV0>; Wed, 15 Aug 2001 17:21:26 -0400
Message-ID: <3B7AE7D2.3070900@erisksecurity.com>
Date: Wed, 15 Aug 2001 17:21:22 -0400
From: David Ford <david@erisksecurity.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VM and N-order allocation failed.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've a friend who has a small box doing routing/firewalling/nat for a 
/27 and the bandwidth is pretty tiny.  The machine has 32megs of ram and 
100 in swap.

It dies anywhere from an hour after reboot to 12 hours later, on console 
are messages like so "__alloc_pages: 0-order allocation failed." and 
"ip_conntrack: table full, dropping packet."

His prior kernel was 2.4.7, nothing special, he's using 3com 
3cSOHO100-TX and Cpq Neteligent 10/100.  I just upped him to 2.4.8 as a 
starter and we'll see how it's going.  I don't have direct access to the 
box so I can't give complete information.

Comments and suggestions welcomed,

David


