Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUDETQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 15:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbUDETQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 15:16:51 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:13189 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263166AbUDETQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 15:16:43 -0400
Message-ID: <4071B093.9030601@nortelnetworks.com>
Date: Mon, 05 Apr 2004 15:16:35 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: bero@arklinux.org, linux-kernel@vger.kernel.org
Subject: Re: Catching SIGSEGV with signal() in 2.6
References: <Pine.LNX.4.58.0404050824310.13367@build.arklinux.oregonstate.edu> <20040405181707.GA21245@mail.shareable.org>
In-Reply-To: <20040405181707.GA21245@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> bero@arklinux.org wrote:
> 
>>... doesn't seem to be possible anymore.
>>
>>See http://www.openoffice.org/issues/show_bug.cgi?id=27162
>>
>>Is this change intentional, or a bug?
> 
> 
> On 2.6.3, x86, SIGSEGV is being caught just fine in my test program,
> with the correct fault address, with or without SA_SIGINFO.

SA_SIGINFO implies sigaction().  The original poster was talking about 
signal().

That said, it seems to work with 2.6.4 on ppc32.

Chris
