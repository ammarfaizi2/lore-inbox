Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267758AbTADArx>; Fri, 3 Jan 2003 19:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267759AbTADArx>; Fri, 3 Jan 2003 19:47:53 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:61702 "EHLO
	falcon.vispa.com") by vger.kernel.org with ESMTP id <S267758AbTADArw>;
	Fri, 3 Jan 2003 19:47:52 -0500
Message-ID: <3E163117.6060901@walrond.org>
Date: Sat, 04 Jan 2003 00:55:51 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: menuconfig Bug in 2.5.54
References: <3E156D61.2040105@walrond.org> <3E15EDD4.98FF8EBF@linux-m68k.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm It works here now. (I got it to work after my email by editing the 
.config file by hand and running it through make oldconfig). Now it 
seems to work in make menuconfig as well.

I'll revert to my original .config (copied from 2.5.53) and try from 
scratch again, and get back to you

Andrew

Roman Zippel wrote:
> Hi,
> 
> Andrew Walrond wrote:
> 
> 
>>In the PCI Bus section, setting the pci access method to BIOS or direct
>>does not get saved on exit. It always defaults back to "Any" on next
>>make menuconfig
> 
> 
> Can you send me your .config? I cannot reproduce it here.
> 
> bye, Roman
> 


