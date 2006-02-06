Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWBFTOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWBFTOd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWBFTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:14:33 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:43075 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932206AbWBFTOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:14:33 -0500
In-Reply-To: <1139250251.10437.39.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0602061116190.11785-100000@gate.crashing.org> <1139250251.10437.39.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DC17879A-2B03-4D20-865F-C89386A393EF@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Revert serial 8250 console fixes
Date: Mon, 6 Feb 2006 13:14:46 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 6, 2006, at 12:24 PM, Alan Cox wrote:

> On Llu, 2006-02-06 at 11:20 -0600, Kumar Gala wrote:
>> Revert Alan's SMP related console race fix as it breaks on some  
>> embedded
>> PowerPC's.
>
> Please figure out why your hardware is misbehaving before you make a
> mess of everyone elses stuff. I've seen nothing from you in the way of
> register dumps when this occurs. You need to find out what is actually
> happening on your board.

I wan't trying to be difficult, just looking for next steps.  I  
replied to your initial suggestion but never heard back on what to  
try or do going forward.

Can you explain further why you had to change wait_for_xmitr() from  
testing BOTH_EMPTY to UART_LSR_THRE.

Also, what exactly would you be looking for in a register dump?

thanks

- kumar
