Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTLGGuV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 01:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbTLGGuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 01:50:21 -0500
Received: from web40506.mail.yahoo.com ([66.218.78.123]:55897 "HELO
	web40506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262176AbTLGGuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 01:50:18 -0500
Message-ID: <20031207065017.48483.qmail@web40506.mail.yahoo.com>
Date: Sat, 6 Dec 2003 22:50:17 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: 2.4.23 hard lock, 100% reproducible.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the exact same thing happen to me about 
a year ago, with the same error message. It
started after I had upraded my kernel. It 
turned out one of my RAM sticks had gone
bad. Do you have another machine you can
test 2.4.23 with?


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

-

=====
I code, therefore I am

__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/
