Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWCIKYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWCIKYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 05:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWCIKYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 05:24:24 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:30471 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S1751784AbWCIKYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 05:24:23 -0500
X-Obalka-From: mmokrejs@ribosome.natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Message-ID: <4410024B.1030706@ribosome.natur.cuni.cz>
Date: Thu, 09 Mar 2006 11:24:11 +0100
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051002
X-Accept-Language: cs
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, gregkh@suse.de, bunk@stusta.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net,
       Neil Brown <neilb@cse.unsw.edu.au>, Dave Hansen <haveblue@us.ibm.com>,
       Nathan Scott <nathans@sgi.com>
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
References: <20060306223545.GA20885@kroah.com>	<20060308222652.GR4006@stusta.de>	<20060308225029.GA26117@suse.de>	<Pine.LNX.4.64.0603081502350.32577@g5.osdl.org> <20060308152928.21afef81.akpm@osdl.org>
In-Reply-To: <20060308152928.21afef81.akpm@osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>
>>
>>On Wed, 8 Mar 2006, Greg KH wrote:
>>
>>>None, as I am expecting 2.6.16 to be out any day now.
>>
>>Sadly, until the FC5 problems re at least somewhat more understood, I 
>>don't think that's going to happen.
>>
>>Trying to chase down Andrew's "laptop from hell" has also delayed even 
>>doing a -rc6, although that is imminent.

> 
> - It would be nice to get Martin MOKREJ
>   <mmokrejs@ribosome.natur.cuni.cz>'s full 16GB recognised again.  Dave
>   Hansen is working on that.

I tried a cold boot yesterday after got physical access to the 
machine. I couldn't reproduce the problem nor with plain 2.6.16-rc5 
nor the same patched with printk patch from Dave Hansen. I touched 
all the DIMMs and have to admit all of them are rather loosely 
fitted into the mainboard. I will probably flash the BIOS. I will 
retry few more reboots and if I manage to reproduce it I'll post 
back. Otherwise, consider it either mechanical problem with the size 
of those Kingston 2GB DDR DIMMs or MSI9136 mainboard layout or BIOS 
bug. Description of the interresting board capable of even 32GB RAM 
is at
http://www.msicomputer.com/product/p_spec.asp?model=E7520_Master-S2M&class=spd

Martin
