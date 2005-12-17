Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVLQUZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVLQUZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVLQUZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:25:09 -0500
Received: from tag.witbe.net ([81.88.96.48]:20107 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S964805AbVLQUZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:25:08 -0500
Message-Id: <200512172023.jBHKNiD15808@tag.witbe.net>
Reply-To: <rol@witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: "'Kyle Moffett'" <mrmacman_g4@mac.com>, "'Andi Kleen'" <ak@suse.de>
Cc: "'Adrian Bunk'" <bunk@stusta.de>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <arjan@infradead.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Sat, 17 Dec 2005 21:23:42 +0100
Organization: Witbe.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <714652CE-EA33-4DD0-B9BB-C1D0E597F7F2@mac.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcYDRtrLKasHH/kORKaIUc9WyIxAGAAAK2hA
x-ncc-regid: fr.witbe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> One comment on x86-64 vs. x86:  There are restrictions on where in  
> memory your process stacks can be located on a 32-bit 
> platform.  They  
> need to reside in lowmem, which means under certain circumstances  
> your lowmem can get too fragmented to create new processes even  
> though you still have a lot of available RAM.

But where does these restrictions come from ? As far as I know, stack
is referenced to by SS:ESP registers, and nothing in the x86 architecture
prevents them from pointing outside of lowmem... Isn't this simply a
Linux design restriction ?

Regards,
Paul


Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur
"Some people dream of success... while others wake up and work hard at it" 

"I worry about my child and the Internet all the time, even though she's 
too young to have logged on yet. Here's what I worry about. I worry that 
10 or 15 years from now, she will come to me and say 'Daddy, where were 
you when they took freedom of the press away from the Internet?'"
--Mike Godwin, Electronic Frontier Foundation 

