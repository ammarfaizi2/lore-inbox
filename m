Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263436AbVCJWzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbVCJWzw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbVCJWqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:46:30 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:60301 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262362AbVCJWkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:40:18 -0500
Message-ID: <4230CCCB.6030909@mesatop.com>
Date: Thu, 10 Mar 2005 15:40:11 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org, Steven Cole <elenstev@mesatop.com>
Subject: Re: Someting's busted with serial in 2.6.11 latest
References: <20050309155049.4e7cb1f4@dxpl.pdx.osdl.net> <20050310195326.A1044@flint.arm.linux.org.uk>
In-Reply-To: <20050310195326.A1044@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Mar 09, 2005 at 03:50:49PM -0800, Stephen Hemminger wrote:
> 
>>Some checkin since 2.6.11 has caused the serial driver to
>>drop characters.  Console output is chopped and messages are garbled.
>>Even the shell prompt gets truncated.
> 
> 
> There was a problem with 2.6.11-bk1 which should now be resolved.
> 
> Is this still true of the latest bk kernel?  Also, seeing the kernel
> messages may provide some hint.
> 

Here is a post I made perhaps relevant to this.

http://marc.theaimsgroup.com/?l=linux-kernel&m=111042402103071&w=2

I'll test current bk tonight, but I don't see any recent fix to
drivers/serial/8250.c when browsing linux.bkbits.net/linux-2.6.

Steven
