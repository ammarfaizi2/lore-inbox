Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSLQECl>; Mon, 16 Dec 2002 23:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSLQECl>; Mon, 16 Dec 2002 23:02:41 -0500
Received: from mail.webmaster.com ([216.152.64.131]:38389 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S264637AbSLQECk> convert rfc822-to-8bit; Mon, 16 Dec 2002 23:02:40 -0500
From: David Schwartz <davids@webmaster.com>
To: <jsherman@stuy.edu>, Mark Mielke <mark@mark.mielke.cc>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Mon, 16 Dec 2002 20:10:42 -0800
In-Reply-To: <20021216160706.GA18431@rootbox>
Subject: Re: Intel P6 vs P7 system call performance
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20021217041036.AAA6435@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Dec 2002 11:07:06 -0500, Jonah Sherman wrote:

>On Mon, Dec 16, 2002 at 12:54:32PM -0500, Mark Mielke wrote:

>>Programs that self verify their own CRC may get a little confused (are
>>there any of these left?), but other than that, 'goto is better avoided'
>>as well, but sometimes 'goto' is the best answer.

>This shouldn't cause any problems.  The only way this would cause a problem
>is if the program had direct system calls in it, but as long as they are
>using libc(what self-crcing program doesn't use libc?), the changes would
>only be made to code pages inside libc, so the program's own code pages
>would remain untouched.

	A program that checked its own CRC would probably be statically linked. This 
is especially likely to be true if the CRC was for security reasons.

	DS


