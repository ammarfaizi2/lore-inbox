Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUCLKds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 05:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUCLKds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 05:33:48 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:13573 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261417AbUCLKdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 05:33:47 -0500
Subject: Re: Abysmal network performance since 2.4.25 !!!!!...
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: psycosonic <psycosonic@rootisg0d.org>
Cc: linux-net@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <004c01c407cf$5fffa270$0700a8c0@darkgod>
References: <004c01c407cf$5fffa270$0700a8c0@darkgod>
Content-Type: text/plain
Message-Id: <1079087525.1145.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Fri, 12 Mar 2004 11:32:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-12 at 02:14, psycosonic wrote:
> Hey.
> 
> I'm having some problems since i updated from kernel 2.4.24 to 2.4.25 .. it
> seems that 2.4.25 has some real performance problems.
> The problem is that i can't get the NIC's to work fine.. i don't know why, 
> i've already used several kernel configurations..
> i've also tried with patch2.4.25pre4 and... nothin' ...even used another 
> switch 10/100mbit.. not even with patch-2.4.26pre2 it goes normal,
> I've compiled the kernel in another computer, with too many different 
> configurations, different hardware.. etc.. and the result is the same.
> Some friends of mine are having the same problem.
> Well.. with kernel 2.4.24 i usually had a max speed of 12Mb/s .. now , with 
> 2.4.25 it only goes to 2,2Mb/s MAX speed.  :(
> I've tried to use vsftpd, proftpd, apache 1.3.x, apache 2.x, samba.. etc 
> etc.. with kernel 2.4.24 works pretty fine... but since 2.4.25.. wow..
> Not even with the patches 2.4.25rcX it worked.. and.. i don't know what more 
> to do.

Suggestion: take a look at the changelog for 2.4.25 and see what changes
could have effect on your network performance.

For example, I had problems with my 3Com card in 2.6.4-mm1, but no on
2.6.3-mm1, so looking at the changelog I saw changes made into 3c59x.c.
Reverting one of those changes fixed my problem.

