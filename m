Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbUDZMlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUDZMlZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 08:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUDZMlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 08:41:25 -0400
Received: from dsl081-101-153.den1.dsl.speakeasy.net ([64.81.101.153]:35755
	"EHLO mail.chen-becker.org") by vger.kernel.org with ESMTP
	id S263836AbUDZMlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 08:41:22 -0400
Message-ID: <408D036D.1010701@chen-becker.org>
Date: Mon, 26 Apr 2004 06:41:17 -0600
From: Derek Chen-Becker <derek@chen-becker.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mirko Caserta <mirko@mcaserta.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 8139too not working in 2.6
References: <opr62ahdvlpsnffn@mail.mcaserta.com>
In-Reply-To: <opr62ahdvlpsnffn@mail.mcaserta.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mirko Caserta wrote:
> 
> Yes, I know, it's a damn cheap eth card and I should get it replaced :)
> 
> Besides that, this card works just fine with 2.4.25 while it refuses to  
> work on a recent 2.6 kernel. I tried 2.6.5 and even  
> 2.6.5-rc2-mm2-broken-out with no luck.
> 

Mine works fine in 2.6.5:

eth0: RealTek RTL8139 at 0xca844000, xx:xx:xx:xx:xx:xx, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
eth1: RealTek RTL8139 at 0xca895000, xx:xx:xx:xx:xx:xx, IRQ 3
eth1:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1

lspci:

00:03.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
00:04.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)

Derek


-- 
+---------------------------------------------------------------+
| Derek Chen-Becker                                             |
| derek@chen-becker.org                                         |
| http://chen-becker.org                                        |
|                                                               |
| PGP key available on request or from public key servers       |
| ID: 21A7FB53                                                  |
| Fngrprnt: 209A 77CA A4F9 E716 E20C  6348 B657 77EC 21A7 FB53  |
+---------------------------------------------------------------+
