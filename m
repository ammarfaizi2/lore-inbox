Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUJES0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUJES0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUJES0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:26:47 -0400
Received: from secundus.edoceo.com ([216.162.208.165]:54402 "EHLO
	secundus.edoceo.com") by vger.kernel.org with ESMTP id S262418AbUJES0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:26:30 -0400
From: "David Busby" <busby@edoceo.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: /dev/misc/inotify 0.11
Date: Tue, 5 Oct 2004 11:26:29 -0700
Message-ID: <82C88232E64C7340BF749593380762021166F5@seattleexchange.SMC.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <82C88232E64C7340BF749593380762021166F3@seattleexchange.SMC.LOCAL>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> List,
>   I patched my 2.6.8.1 kernel with the inotify-0.11.  There 
> were some sample utils that in C that came with it.  Thanks.  
> I've successfully used those to work with inotify.  Here's what's bad:
> 
> 1> When I say `cat /dev/misc/inotify' my machine stops responding
> instantly.  I've not had a chance to see what happens.  I 
> know I'll not normally say that but when I say something else 
> dumb like cat /dev/misc/rtc cat will simply wait, not choke 
> up my whole system.
> 
> 2> Reading from /dev/misc/inotify with PERL produces the same effect.
> 
> I don't know enough about kernel hacking to really debug this 
> really well.  I peeked at the code and there still seems to 
> be calls to dnotify functions, can't I remove those?  I said this in
> drivers/char/inotify.c(54) static int inotify_debug_flags = 
> INOTIFY_DEBUG_ALL; so I'll recompile and see what happens.
> 
> 
> David Busby
> Edoceo, Inc.
> http://www.edoceo.com/

So now I upgraded to inotify-0.12 against the same kernel.  I'm still
having the same issues.

