Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRA2UTn>; Mon, 29 Jan 2001 15:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129235AbRA2UTe>; Mon, 29 Jan 2001 15:19:34 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:22035 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129101AbRA2UTV>; Mon, 29 Jan 2001 15:19:21 -0500
From: Stefani Seibold <stefani@seibold.net>
Date: Mon, 29 Jan 2001 21:17:54 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
Cc: Thunder from the hill <thunder@ngforever.de>, linux-kernel@vger.kernel.org
To: James Simmons <jsimmons@suse.com>
In-Reply-To: <Pine.LNX.4.21.0101290938560.6646-100000@euclid.oak.suse.com>
In-Reply-To: <Pine.LNX.4.21.0101290938560.6646-100000@euclid.oak.suse.com>
Subject: Re: patch for 2.4.0 disable printk
MIME-Version: 1.0
Message-Id: <01012921175400.01429@deepthought.seibold.net>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 29. Januar 2001 18:40 schrieb James Simmons:
> > You are right... this patch make no sense on a computer system with human
> > interactions. But think on tiny hidden computers, like in a dishwasher or
> > a traffic light. This computer are standalone, if it crash, then it will
> > be rebooted.
> > Nobody will attach a terminal to this kind of computer, nobody is
> > interessted on a logfile. Nobody will see a oops, because nobdy is there.
>
> What do you suggest we do with /dev/console and stdin, stdout, stderr?
> The kernel needs a /dev/console to boot with.

This patch does not modify the /dev/console, nor stdin/stdout/stderr. I think 
you should try it, bevor you are posting...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
