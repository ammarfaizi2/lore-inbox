Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbWJKMdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWJKMdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWJKMdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:33:25 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:29122 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751239AbWJKMdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:33:24 -0400
Message-ID: <452CE492.2080607@s5r6.in-berlin.de>
Date: Wed, 11 Oct 2006 14:33:22 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: simoneau@ele.uri.edu, sparclinux@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
References: <20061005211543.GA18539@ele.uri.edu>	<20061009.183607.63736982.davem@davemloft.net>	<20061010132943.GB18539@ele.uri.edu> <20061010.151751.90998930.davem@davemloft.net>
In-Reply-To: <20061010.151751.90998930.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2006 12:17 AM, David Miller wrote:
> From: Will Simoneau <simoneau@ele.uri.edu>
> Date: Tue, 10 Oct 2006 09:29:43 -0400
> 
>> I still get:
>> 
>> Kernel unaligned access at TPC[10162164] ether1394_reset_priv+0x2c/0xe0 [eth1394]
>> Kernel unaligned access at TPC[10163148] ether1394_data_handler+0xdd0/0x1060 [eth1394]
>> 
>> The second one triggers on every packet received, the first only triggers once in a while.
>> 
>> If you want more gdb info or a disassembly just ask.
> 
> Hmmm, can you do me a favor?  Build ieee1394 and eth1394 statically
> into your kernel, reproduce, and post the kernel log messages
> and the vmlinux image somewhere where I can fetch them.
> 
> I should be able to fix this once I have that.
> 
> Thanks a lot.

Please keep linux1394-devel informed too. (Now added to Cc list.)
-- 
Stefan Richter
-=====-=-==- =-=- -=-==
http://arcgraph.de/sr/
