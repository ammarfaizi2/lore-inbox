Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVBSJUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVBSJUR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVBSJTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:19:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55499 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261703AbVBSJTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 04:19:08 -0500
Message-ID: <42170477.5070401@pobox.com>
Date: Sat, 19 Feb 2005 04:18:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Adrian Bunk <bunk@stusta.de>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/smc-mca.c: cleanups
References: <20050219083431.GN4337@stusta.de>  <4216FBCB.8040807@pobox.com> <1108804140.6304.67.camel@laptopd505.fenrus.org>
In-Reply-To: <1108804140.6304.67.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 2005-02-19 at 03:41 -0500, Jeff Garzik wrote:
> 
>>Adrian Bunk wrote:
>>
>>>This patch contains the following cleanups:
>>>- make a needlessly global function static
>>>- make three needlessly global structs static
>>>
>>>Since after moving the now-static stucts to smc-mca.c the file smc-mca.h 
>>>was empty except for two #define's, I've also killed the rest of 
>>>smc-mca.h .
>>
>>It looks like the structs should be 'static const', not just 'static'.
>>
>>This comment is applicable to similar changes, also.  Use 'const' 
>>whenever possible.
> 
> 
> does that even have meaning in C? In C++ it does, but afaik in C it
> doesn't.

Of course it has meaning in C.

	Jeff



