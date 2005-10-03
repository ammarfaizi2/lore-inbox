Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVJCB2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVJCB2M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 21:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVJCB2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 21:28:12 -0400
Received: from relay03.pair.com ([209.68.5.17]:7954 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S932110AbVJCB2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 21:28:11 -0400
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: what's next for the linux kernel?
Date: Sun, 2 Oct 2005 20:27:45 -0500
User-Agent: KMail/1.8.1
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
References: <20051002204703.GG6290@lkcl.net> <54300000.1128297891@[10.10.2.4]> <20051003011041.GN6290@lkcl.net>
In-Reply-To: <20051003011041.GN6290@lkcl.net>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510022028.07930.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd venture to say that Linux scalability is fantastic. This also sounds like 
a repeat of a debate that happened ten years ago.

I too was intrigued by Andrew's comment about 'finishing the kernel', though 
I'm guessing (albeit without ever having spoken to Andrew personally) that it 
was partially in jest. What it does suggest, though, is a point that KDE 
desktop developer Aaron Seigo has made recently about the focus moving up the 
stack.

If we are admirably tackling the problems of hardware compatibility, 
stability, scalability and we've implemented most of the important features 
that belong in the kernel, then a lot of the development fire for a so-called 
complete Linux system is going to have to move up the stack - into the 
userland.

Indeed, adding 100 cores to my Pentium 4 isn't going to do me a damned bit of 
good when Akregator goes to query some 40 RSS feeds and Kontact blocks, 
refusing to process GUI events. It's also not going to make compiling a 
single .c file any faster. 

I have no doubt that the bright minds here on LKML will continue to find 
places to improve Linux's scalability, but that certainly doesn't require 
rebuilding the kernel - we're already doing remarkably well in the 
scalability department.

The bottom line is that the application developers need to start being clever 
with threads. I think I remember some interesting rumors about Perl 6, for 
example, including 'autothreading' support - the idea that your optimizer 
could be smart enough to identify certain work that can go parallel.

As dual cores and HT become more popular, the onus is going to be on the 
applications, not the OS, to speed up. 

Regards,
Chase Venters

On Sunday 02 October 2005 08:10 pm, Luke Kenneth Casson Leighton wrote:
> ... words ...
