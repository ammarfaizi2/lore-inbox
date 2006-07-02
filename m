Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWGBSBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWGBSBy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWGBSBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:01:54 -0400
Received: from terminus.zytor.com ([192.83.249.54]:8170 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964816AbWGBSBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:01:53 -0400
Message-ID: <44A809E1.4040001@zytor.com>
Date: Sun, 02 Jul 2006 11:01:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Robert Hancock <hancockr@shaw.ca>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59:	undefined
 reference to `__stack_chk_fail'
References: <fa.iPhEst5K48JbrGWRr3l3/GEBesY@ifi.uio.no>	 <fa.iffnN5wM1UwqtCYhmqLAkGCMC2o@ifi.uio.no> <44A802FE.2020203@shaw.ca>	 <44A80614.3090802@zytor.com> <1151862663.3111.27.camel@laptopd505.fenrus.org>
In-Reply-To: <1151862663.3111.27.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> There is a good answer to that question, and that is, the kernel is the 
>> special case.  It DOES make sense to let the distribution set the 
>> default to whatever they think the end user should use for applications. 
> 
> yeah.. but it's called "CFLAGS environment variable" :-)
> 

Absolutely not.  Setting a CFLAGS environment variable has an effect 
which is at very best unpredictable when dealing with a great span of 
applications.  Setting a CC environment variable is actually safer in 
many ways, but even that is cantankerous.

	-hpa
