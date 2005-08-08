Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVHHHNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVHHHNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 03:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVHHHNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 03:13:40 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:5796 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750742AbVHHHNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 03:13:40 -0400
Date: Mon, 8 Aug 2005 09:13:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: Dave Jiang <djiang@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 frame pointer via thread context
In-Reply-To: <p73slxn1dry.fsf@bragg.suse.de>
Message-ID: <Pine.LNX.4.61.0508080912380.18088@yvahk01.tjqt.qr>
References: <42F3EC97.2060906@mvista.com.suse.lists.linux.kernel>
 <p73slxn1dry.fsf@bragg.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Am I doing something wrong, or is this intended to be this way on
>> x86_64, or is something incorrect in the kernel? This method works
>> fine on i386. Thanks for any help!
>
>I just tested your program on SLES9 with updated kernel and RBP
>looks correct to me. Probably something is wrong with your user space
>includes or your compiler.

Note that there is -fomit-frame-pointer which might give different results 
than without the option (or explicitly -fno-omit-frame-pointer).


Jan Engelhardt
-- 
