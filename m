Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbUKUAPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbUKUAPG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 19:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUKUAOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 19:14:11 -0500
Received: from the.earth.li ([193.201.200.66]:62629 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S261679AbUKUALm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 19:11:42 -0500
Date: Sun, 21 Nov 2004 00:11:38 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Chris Bainbridge <C.J.Bainbridge@ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (yet another) probable GPL violation [inexq]
Message-ID: <20041121001138.GP10285@earth.li>
References: <200404221142.57990.C.J.Bainbridge@ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404221142.57990.C.J.Bainbridge@ed.ac.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 11:42:57AM +0100, Chris Bainbridge wrote:
> The Inexq ISW054t is a 802.11g broadband router with 4 port switch. It's 
> getting quite popular due to its low price. I suspect that it runs linux, yet 
> comes with no mention of the GPL. I've emailed Inexq (the company formerly 
> known as Unex) but they haven't replied. 
> 
> You can download the firmware from : ftp://ftp.inexq.com/Drivers/ISW054t.zip
> 
> The zip contains a file 
> ISW054t-S1-200712T3.img which `file` identies as "PPCBoot image"
> 
> strings shows:
> Uncompressing Linux...
> Ok, booting the kernel.
> UNEX-GISL-T-L2-200712T3_U.bin
> 
> Theres a gzip image at offset 0x2048 which unpacks to 1.8MB : 
> dd if=ISW054t-S1-200712T3.img bs=8264 skip=1 |zcat > 
> UNEX-GISL-T-L2-200712T3_U.bin
> 
> I've searched for the usual magic numbers but can't find the root fs. Any 
> pointers would be appreciated. 

Did you ever get anywhere with this? The ISW054u (like the t but with a
USB port AFAICT) looks pretty much like the sort of hardware I want to
play with, but without source it wouldn't be much use to me (I need
IPv6 and Speedtouch USB support added).

J.

-- 
Revd. Jonathan McDowell, ULC | noodles is used in pad thai
