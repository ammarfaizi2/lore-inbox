Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVHHO5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVHHO5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbVHHO5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:57:17 -0400
Received: from dvhart.com ([64.146.134.43]:16513 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750925AbVHHO5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:57:16 -0400
Date: Mon, 08 Aug 2005 07:57:13 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: michael@ellerman.id.au, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Nikhil Dharashivkar <nikhildharashivkar@gmail.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove warning about e1000_suspend
Message-ID: <406250000.1123513032@[10.10.2.4]>
In-Reply-To: <200508081849.34831.michael@ellerman.id.au>
References: <256850000.1123442258@10.10.2.4> <17db6d3a05080723096ec26531@mail.gmail.com> <200508081849.34831.michael@ellerman.id.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Michael Ellerman <michael@ellerman.id.au> wrote (on Monday, August 08, 2005 18:49:34 +1000):

> On Mon, 8 Aug 2005 16:09, Nikhil Dharashivkar wrote:
>> Hi Martin,
>>     But e1000_notify_reboot () function calls this e1000_suspend()
>> function irrespective of  CONFIG_FM is defined or not. So according to
>> your soution, what if CONFIG_FM is not defined.
> 
> Does it? I can't find it.
> 
> Martin's patch works for me.

Aha. e1000_notify_reboot dissappeared between 2.6.13-rc3 and 2.6.13-rc4,
which caused the warning to start. So patch is good - Andrew, could you
still apply it? Will resend if you need.

M.

