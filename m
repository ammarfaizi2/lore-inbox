Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUCILfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbUCILfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:35:19 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:42190 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261880AbUCILfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:35:11 -0500
Message-ID: <404DABEC.4070605@stesmi.com>
Date: Tue, 09 Mar 2004 12:35:08 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjoern Schmidt <lucky21@uni-paderborn.de>
CC: len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: fsb of older cpu
References: <A6974D8E5F98D511BB910002A50A6647615F47CB@hdsmsx402.hd.intel.com> <1078815523.2342.535.camel@dhcppc4> <404DA7A8.4090109@uni-paderborn.de>
In-Reply-To: <404DA7A8.4090109@uni-paderborn.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjoern.

> In the System Programming Guide i can read that i can reprogram the
> clock multiplier by setting RESET# to low and A20M#, IGNNE#, LINT[1]
> and LINT[0] to 1111 for 1/2. Unfortunately i dont know how to
> program this in assembler code, i can several programming
> languages, but not yet asm :(
> Can you recommend a good online book?

Think for a moment what happens when you pull RESET# low :)

It... resets the chip thereby resetting the computer.

It also (as far as I know) can't be pulled low by software.

Neither can the other pins.

// Stefan
