Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267506AbUBSTui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbUBSTuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:50:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38411 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S267506AbUBSTtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:49:15 -0500
Message-ID: <40351306.1080207@zytor.com>
Date: Thu, 19 Feb 2004 11:48:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
References: <Pine.LNX.4.58.0402181422180.2686@home.osdl.org> <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <Pine.LNX.4.58.0402191150120.1270@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402191150120.1270@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 19 Feb 2004, Linus Torvalds wrote:
> 
>>Basic approach: add two bits to the VFS dentry flags. That's all that is 
>>needed. Then you have two new system calls:
> 
>                         ^^^
> 
>> - set_bit_one(dirfd)
>> - set_bit_two_if_one_is_set(dirfd);
>> - check_or_create_name(dirfd, name, case_table_pointer, newfd);
> 
> 
>  [ deletia ]
> 
> 
>>Am I a super-intelligent bastard, or am I a complete nincompoop? You
>>decide.
> 
> 
> I think my lack of counting ability basically answers that question.
> 
> Damn.
> 

How about a compomise - super-intelligent complete nincompoop bastard?

[:^)

	-hpa

