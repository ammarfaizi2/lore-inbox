Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbTKUHhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 02:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbTKUHhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 02:37:19 -0500
Received: from terminus.zytor.com ([63.209.29.3]:1715 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S264318AbTKUHhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 02:37:18 -0500
Message-ID: <3FBDC0A4.7080605@zytor.com>
Date: Thu, 20 Nov 2003 23:37:08 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Announce: ndiswrapper
References: <Pine.LNX.4.44.0311202316500.13351-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311202316500.13351-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> (I agree, the fact that the x86 paging hardware makes 1/2/3 be equivalent 
> makes it an even _less_ useful abstraction, but I think it is a mistake to 
> think that it would be any more useful even if the page tables wasted 
> precious bits on unnecessary level information).
 >

Actually, the paging hardware makes 0/1/2 equivalent; some *other* 
primitives make 1/2/3 equivalent...

> 
> Multi-ring was a failure. Let it go. The only reason it is making
> something of a comeback (Palladium-whatever-it-is-called-today) has no
> good technical reasons, and is purely about other things.
> 

No doubt.  However, I wish they would have at least taken the few useful 
thing they had in the i286 botch, like the RPL, and made them available 
to the paging system.  That way i386 would have had "access this as from 
user space" like most architectures have.

	-hpa

