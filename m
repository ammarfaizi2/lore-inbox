Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265296AbTLGEeh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 23:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbTLGEeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 23:34:37 -0500
Received: from ca1.symonds.net ([66.92.42.136]:18305 "EHLO symonds.net")
	by vger.kernel.org with ESMTP id S265296AbTLGEee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 23:34:34 -0500
Message-ID: <02a901c3bc7b$69294ee0$7a01a8c0@gandalf>
From: "Mark Symonds" <mark@symonds.net>
To: "Philippe Troin" <phil@fifi.org>
Cc: <linux-kernel@vger.kernel.org>
References: <20031207023650.GA772@symonds.net> <87he0ds3sv.fsf@ceramic.fifi.org>
Subject: Re: 2.4.23 hard lock, 100% reproducible.
Date: Sat, 6 Dec 2003 20:34:32 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> 
> Not even sysrq?
>  

I did get msgs twice here in the past few hours, 
but only sometimes does it give anything.  Here's 
what it said: 

Unable to handle kernel NULL pointer
dereference at virtual address: 00000000

 printing eip:
c02363dd
*pde=00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c02363d>]  Not tainted
EFLAGS: 00010217

eax: 00000006   ebx: 00000000  ecx: 7a01a8c0   ecx: c700b2a0
esi: c0299ce0   edi: 000001b7  ebp: c0299d94   esp: c0299c54
ds: 0018  es: 0018  ss: 0018

process: swapper (pid: 0, stackpage = c0299000)

Other than that, nothing.  Is there a patch out there 
that will simply make 2.4.22 secure?  Things run great
on that kernel. 

-- 
Mark

