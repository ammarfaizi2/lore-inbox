Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSGLCcq>; Thu, 11 Jul 2002 22:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317979AbSGLCcp>; Thu, 11 Jul 2002 22:32:45 -0400
Received: from klaatu.zianet.com ([204.134.124.201]:5264 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S314149AbSGLCcp>;
	Thu, 11 Jul 2002 22:32:45 -0400
Message-ID: <3D2E41EB.6040504@zianet.com>
Date: Thu, 11 Jul 2002 20:41:47 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020709
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: Matthew Hall <matt@ecsc.co.uk>, Kernel <linux-kernel@vger.kernel.org>,
       jgarzik@mandrakesoft.com
Subject: Re: [PROBLEM] sundance on d-link dfe-580tx
References: <Pine.LNX.4.33.0206112336340.2253-100000@presario>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to give some confirmation of the operation of this new driver.
I had had the same error messages as Matthew did. I followed
the instructions on Donald's site on making the new drivers and
it works great now. It found everything correctly with the following
output:

sundance.c:v1.07 7/3/2002 Written by Donald Becker <becker@scyld.com>
http://www.scyld.com/network/sundance.html
eth0: OEM Sundance Technology ST201 at 0xdc00, 00:05:5d:e6:2b:19, IRQ 11.
eth0: MII PHY found at address 0, status 0x782d advertising 01e1.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1.
eth1: OEM Sundance Technology ST201 at 0xd880, 00:05:5d:e6:2b:1a, IRQ 10.
eth1: MII PHY found at address 0, status 0x7809 advertising 01e1.
eth1: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth2: OEM Sundance Technology ST201 at 0xd800, 00:05:5d:e6:2b:1b, IRQ 9.
eth2: MII PHY found at address 0, status 0x7809 advertising 01e1.
eth2: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth3: OEM Sundance Technology ST201 at 0xd480, 00:05:5d:e6:2b:1c, IRQ 11.
eth3: MII PHY found at address 0, status 0x7809 advertising 01e1.
eth3: MII PHY found at address 1, status 0x7809 advertising 01e1.

I am now sending this message over it.
Any idea when this will be merged into mainstream kernel?

Thanks,
Steven


Donald Becker wrote:

>On 11 Jun 2002, Matthew Hall wrote:
>
>  
>
>>To: Kernel <linux-kernel@vger.kernel.org>
>>Cc: becker@scyld.com, jgarzik@mandrakesoft.com
>>    
>>
>...
>  
>
>>I have been testing the D-Link DFE-580TX Quad channel server card (4
>>port nic), on kernel 2.4.18 with little success.
>>
>>Attached are the appropriate results of dmesg, ifconfig, lspci and
>>modules.conf; aswell as the results of the pci-testing tool found on
>>scyld.com, however the card does not support mii testing, claiming to
>>have no MII transceiver.
>>    
>>
>
>Please provide the full detection message.
>
>It appears that you are using a driver that doesn't correctly read the
>EEPROM, and has additional problems.  Try a current driver from
>   http://www.scyld.com/network/ethercard.html
>      ftp://www.scyld.com/pub/network/sundance.c
>   http://www.scyld.com/network/updates.html
>
>and run diagnostic program from
>  http://www.scyld.com/diag/index.html
>
>
>  
>



