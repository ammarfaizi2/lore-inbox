Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTLZGEy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 01:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbTLZGEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 01:04:54 -0500
Received: from terminus.zytor.com ([63.209.29.3]:37836 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S264506AbTLZGEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 01:04:53 -0500
Message-ID: <3FEBCF7B.5030208@zytor.com>
Date: Thu, 25 Dec 2003 22:04:43 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
References: <1072403207.17036.37.camel@clubneon.clubneon.com> <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Similarly, what the _hell_ does the gcc extension
> 
> 	int a;
> 
> 	(char)a += b;
> 
> really mean? The whole extension is just braindamaged, again probably 
> because there were non-C people involved at some point. It's very much 
> against the C philosophy. I bet 99% of the people on this list have no 
> clue what the exact semantics of the above are.
> 

Oh, right.  When I heard "cast as lvalue" I envisioned:

*(char *)foo = bar;

... being a warning, but that's not a cast, even though the pointer is.

	-hpa



