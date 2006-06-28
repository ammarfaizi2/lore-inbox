Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWF1QlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWF1QlM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWF1QlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:41:12 -0400
Received: from unn-206.superhosting.cz ([82.208.4.206]:13281 "EHLO
	mail.aiken.cz") by vger.kernel.org with ESMTP id S1751380AbWF1QlK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:41:10 -0400
Message-ID: <44A2B123.7000304@kernel-api.org>
Date: Wed, 28 Jun 2006 18:41:07 +0200
From: Lukas Jelinek <info@kernel-api.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; cs-CZ; rv:1.7.12) Gecko/20050915
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
References: <44A1858B.9080102@kernel-api.org>	<1151495225.8127.68.camel@elijah.suse.cz>	<44A2749D.7030705@kernel-api.org>	<20060628090950.c1862a9e.rdunlap@xenotime.net>	<1151511215.8127.74.camel@elijah.suse.cz> <20060628093619.6b9f2b8c.rdunlap@xenotime.net>
In-Reply-To: <20060628093619.6b9f2b8c.rdunlap@xenotime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>I looked at
>>>>>http://www.kernel-api.org/docs/online/2.6.17/da/dab/structsk__buff.html
>>>>>
>>>>>and you apparently ignore kernel-doc for structs. Cf.
>>>>>include/linux/skbuff.h:177 ff.
>>>>
>>>>There are several problems. The one you describe is probably caused by a
>>>>blank line between the struct and the related comment. Doxygen doesn't
>>>>recognize it correctly (and simply ignores the comment).
>>>
>>>No blank line in this case.
>>
>>Oh, yes, there is a blank line between the comment and the struct. It's
>>a pitty that someone put much effort into writing a usable description,
>>which is then not seen. Anyway, should we find all such occurences in
>>the kernel tree and fix them, or make a workaround for doxygen?
> 
> 
> Which struct are we talking about here?  I missed it.
> 
> I guess the easy answer is Both.
> However, I'm working on fixing up the kernel tree, so sending
> patches is correct IMO.
> 

We are currently talking about struct sk_buff. And there _is_ a single
blank line which avoids to make a relation between the struct and the
comment above.

Lukas

