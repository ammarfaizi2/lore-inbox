Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267513AbUBSTrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267514AbUBSTrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:47:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:22682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267513AbUBSTrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:47:11 -0500
Date: Thu, 19 Feb 2004 11:51:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0402191150120.1270@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
 <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org>
 <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org>
 <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org>
 <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org>
 <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org>
 <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, Linus Torvalds wrote:
> 
> Basic approach: add two bits to the VFS dentry flags. That's all that is 
> needed. Then you have two new system calls:
                        ^^^
>  - set_bit_one(dirfd)
>  - set_bit_two_if_one_is_set(dirfd);
>  - check_or_create_name(dirfd, name, case_table_pointer, newfd);

 [ deletia ]

> Am I a super-intelligent bastard, or am I a complete nincompoop? You
> decide.

I think my lack of counting ability basically answers that question.

Damn.

		Linus "complete nincompoop" Torvalds
