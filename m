Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUEMXHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUEMXHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbUEMXHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:07:51 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:52117 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265245AbUEMXEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:04:52 -0400
Message-ID: <40A3FEB3.3050800@zytor.com>
Date: Thu, 13 May 2004 16:03:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-pre2: tg3: there's no WARN_ON in 2.4
References: <20040503230911.GE7068@logos.cnet> <200405042253.11133@WOLK> <40982AC6.5050208@eyal.emu.id.au> <20040506121302.GI9636@fs.tum.de> <c7rpsg$ghd$1@terminus.zytor.com> <20040513223436.GI22202@fs.tum.de>
In-Reply-To: <20040513223436.GI22202@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
>> 
> AFAIR, the -tiny tree already implements some kind of empty 
> BUG/PAGE_BUG/WARN_ON macros.
> 
> When optimizing for size that way, your suggestion would result in 
> bigger code.
> 

?!?!?!?!?!

If there are no side effects, my suggestion produces zero code.

> And after a quick view, I haven't seen any WARN_ON users in 2.6 that
> seem to rely on side effects.

Then there should be no size difference, either.

	-hpa
