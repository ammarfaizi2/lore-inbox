Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUCAS3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 13:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUCAS3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 13:29:51 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:54471 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261390AbUCAS3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 13:29:49 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Date: Mon, 01 Mar 2004 18:29:47 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 - 8139too timeout debug info
Message-ID: <4043811B.24524.33DB8886@localhost>
In-reply-to: <87d67x91vs.fsf@devron.myhome.or.jp>
References: <4041E38F.31264.2D8C0D2E@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, thanks for debugging. Looks like this problem is not 8139too.
> And same problem should happen with the old driver (probably, it appear
> with "max_interrupt_work=1").
> 
> Umm... I guess this problem is miss config of Edge/Level-Trigger or
> something.  Sorry, I don't know detail.

Well, after running whatever patches you supplied for me to test, I 
can confirm after running it for 30 hours, it works a treat - and 
without having any true measuring devices on network performance, I 
can tell you it is very much faster and responsive all round... on 
downloads, web browsing, FTP - everything.  (as you do say, I did 
used to get pauses sometimes during large file movement/downloads 
etc., but just thought it was normal network activity - I do not get 
them any more!).

Insomuchso I have kept this debug 8139too.c build as a running kernel 
now.

Thank you,

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

