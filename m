Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUFWXtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUFWXtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUFWXtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:49:49 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:63419 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263001AbUFWXtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:49:33 -0400
Message-ID: <40DA16E8.6070902@nortelnetworks.com>
Date: Wed, 23 Jun 2004 19:48:56 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mariusz Mazur <mmazur@kernel.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
References: <200406240102.23162.mmazur@kernel.pl>
In-Reply-To: <200406240102.23162.mmazur@kernel.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Mazur wrote:

> I'm interested in guidelines, not discussion :)
> Kernel guys had a couple of years since 2.4 for discussing this so 
> something
> *must* have been agreed upon.

After a bit of googling...

Andries Brouwer suggested include/linuxabi with arch-specific dirs
H. Peter Anvin apparently suggested putting them in include/abi, with 
arch-specific dirs.  However, he thinks its too much work for 2.6 and sees it as 
an early 2.7 thing.
Matthew Wilcox apparently suggested something similar
Jeff Garzik approved the idea
Rob Landley suggested moving your headers there and then cleaning up the other 
headers, and expressed willingness to submit patches.
Sam Ravnborg supported the idea
Eric Biederman supported the idea, suggested linux-only namespace and 
version-based naming, figured it was 2.7 work
David Miller approved the idea


Maybe this should be a topic for the kernel summit or a BOF session at OLS?

Chris
