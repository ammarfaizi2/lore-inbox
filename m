Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUHaG2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUHaG2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUHaG2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:28:40 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:14010 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S266748AbUHaG1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:27:25 -0400
Message-ID: <41341A42.1070804@drzeus.cx>
Date: Tue, 31 Aug 2004 08:27:14 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC updates
References: <20040830232801.G22480@flint.arm.linux.org.uk>
In-Reply-To: <20040830232801.G22480@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>For anyone who's interested, here's an update to the MMC code Linus
>recently merged.  Essentially, I've added SG support to the MMCI
>primecell driver.
>  
>
Just to make sure I've understood this correctly. SGIO takes a number of 
memory locations and fills these with data from a continous stream of 
data from the card? I.e. only the local memory locations need special 
handling. No seeking on the card? And any "gaps" where data is not 
wanted is handled by upper layers?

Rgds
Pierre

