Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbUDPP7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbUDPP5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:57:34 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:42759 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263315AbUDPP5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:57:16 -0400
Message-ID: <4080029C.4000308@techsource.com>
Date: Fri, 16 Apr 2004 11:58:20 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Felix von Leitner <felix-kernel@fefe.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb broken
References: <20040415202523.GA17316@codeblau.de>	 <407EFB08.6050307@techsource.com> <1082079792.2499.229.camel@gaston>
In-Reply-To: <1082079792.2499.229.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Benjamin Herrenschmidt wrote:
>>What annoys me most about the Radeon driver is the off-by-one error in 
>>the bmove routine.  Whenever text is copied to the right or down, it 
>>gets positioned incorrectly.  I posted the fix, but no one paid attention.
> 
> 
> Mayb it was just "missed" in the flow of hundreds of mails that go
> through this list. Can you re-sent it to me, and also precise which
> kernel version it applies to ?
>

Oh, I failed to mention this bit.

I've seen it in 2.4.22-gentoo-r7 and 2.4.25-gentoo.

The bug is NOT present in Red Hat's 2.4.18-27.7.x

