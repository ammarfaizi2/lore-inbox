Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTKUHqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 02:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTKUHqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 02:46:31 -0500
Received: from adsl-b4-98-13.telepac.pt ([81.193.98.13]:29376 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S264321AbTKUHq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 02:46:29 -0500
Message-ID: <3FBDC30E.2090200@vgertech.com>
Date: Fri, 21 Nov 2003 07:47:26 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Announce: ndiswrapper
References: <Pine.LNX.4.44.0311202316500.13351-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311202316500.13351-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

[...]

> 
> 
> That may be the politically sensitive (except to Intel) correct answer, 
> but in the end I suspect that the _real_ answer is that ring 1/2 are just 
> fundamentally useless, and it has nothing to do with x86 implementation 
> semantics or anything else.
> 

(A bit OT, but...)

Hi Linus!

The good people at Cambridge made a (very nice) VMM that exploits 
ring0/1/3 to let one machine run various kernels independently (the 
kernels need to be ported to the xen arch).

Xen itself executes in ring0 and the "guest" operating systems execute 
in ring1. User code runs in ring3, as usual. They have linux running 
under xen ;)

The project's home page is at 
http://www.cl.cam.ac.uk/Research/SRG/netos/xen/ and one paper describing 
the whole thing is here: 
http://www.cl.cam.ac.uk/netos/papers/2003-xensosp.pdf

Regards,
Nuno Silva


