Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTJ1Hxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 02:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbTJ1Hxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 02:53:54 -0500
Received: from LION-S12.SEAS.UPENN.EDU ([158.130.12.194]:26831 "EHLO
	lion.seas.upenn.edu") by vger.kernel.org with ESMTP id S263871AbTJ1Hxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 02:53:53 -0500
Date: Tue, 28 Oct 2003 02:53:51 -0500
From: Peng Li <lipeng@acm.org>
To: joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: 512MB/1GB RAM & Wireless Card
Message-ID: <20031028075351.GA21962@seas.upenn.edu>
References: <20031028064554.GA20596@seas.upenn.edu> <20031028072645.GB5795@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031028072645.GB5795@triplehelix.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I have CONFIG_ISA=y.  I put my kernel config at

http://www.seas.upenn.edu/~lipeng/x31info/config.txt

The only thing I noticed is that in the dmesg, there is a error
message:

   PCI: Cannot allocate resource region 0 of device 0000:02:00.0

But this message is still there when I unplugged the RAM and the card
is working fine.  

For the kernel, what is the difference between these two situations?

*   1GB RAM, boot with mem=512M
* 512MB RAM, normal boot 

It is not likely to be a hardware issue, since the card works fine with
1GB of memory in Windows XP.


On Mon, Oct 27, 2003 at 11:26:45PM -0800, Joshua Kwan wrote:
> 
> Always the same first question: was CONFIG_ISA enabled in your .config?
> It's what I needed to do to get my Orinoco to work under Linux.
> 
> Interesting that it worked when you unplugged the RAM, but I don't see
> an immediate correlation.
> 
> -- 
> Joshua Kwan


