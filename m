Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVHPEz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVHPEz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 00:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVHPEz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 00:55:59 -0400
Received: from smtpout.mac.com ([17.250.248.89]:3056 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932601AbVHPEz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 00:55:58 -0400
In-Reply-To: <20050816043451.GA25224@taniwha.stupidest.org>
References: <20050815200522.GA3667@sysman-doug.us.dell.com> <AC1976B5-FAFC-4809-B1B2-579D5F14FDFE@mac.com> <20050816043451.GA25224@taniwha.stupidest.org>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C38BFC4F-E00F-4CE8-A4DD-89AE55B898D9@mac.com>
Cc: Doug Warzecha <Douglas_Warzecha@dell.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Date: Tue, 16 Aug 2005 00:55:35 -0400
To: Chris Wedgwood <cw@f00f.org>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 16, 2005, at 00:34:51, Chris Wedgwood wrote:
> On Mon, Aug 15, 2005 at 04:23:37PM -0400, Kyle Moffett wrote:
>> Why can't you just implement the system management actions in the
>> kernel driver?
>
> Why put things in the kernel unless it's really needed?
>
> I'm not thrillied about the lack of userspace support for this driver
> but that still doesn't mean we need to shovel wads of crap into the
> kernel.

I'm worried that it might be more of a mess in userspace than it  
could be
if done properly in the kernel.  Hardware drivers, especially for  
something
as critical as the BIOS, should probably be done in-kernel.  Look at the
mess that X has become, it mmaps /dev/mem and pokes at the PCI busses
directly.  I just don't want an MSI-driver to become another /dev/mem.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E
W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+++) 5  
X R?
tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


