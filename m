Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265797AbUFORp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbUFORp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUFORpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:45:30 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:6095 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S265797AbUFORo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:44:56 -0400
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 15 Jun 2004 18:44:54 +0100
MIME-Version: 1.0
Subject: Re: Oopses with both recent 2.4.x kernels and 2.6.x kernels
Message-ID: <40CF43A6.5170.28D6B4D5@localhost>
X-mailer: Pegasus Mail for Windows (4.21a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI.

I have a box here that was originally running 2.4.x.  I updated to 
2.6.x a few months ago, and all was well.  Then I started to get 
curious oops, none of them the same.

I started to suspect NFS, as I use an old 486 to hold the web pages 
to serve to the box via NFS... the oops occurred every Saturday 
morning @ 4:02.  Lead to me think it was some sort of cron.weekly 
issue with the disc activity and file access or the like, or 
whatever... I didn't know - I was on a fishing exercise (and a lot of 
searching on the LKML)

But, after talking to a member of the HantsLUG, and showing logs and 
stuff, he brought up at the swap size.  This box was once 64Mb, but 
is now 128Mb - with 128Mb swap.  I created an additional swap file 
(256Mb), and (touch wood), no oops since, all heathly :)  I never 
looked at this before, as swap was never used _during_ normal running 
of the box, but as he said maybe the cron.weekly ran a lot of stuff 
that did use it up...

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

