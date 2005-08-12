Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVHLMTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVHLMTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 08:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVHLMTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 08:19:43 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:32454 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751021AbVHLMTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 08:19:43 -0400
From: Grant Coady <Grant.Coady@gmail.com>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine NIC, Via SATA or reiserfs broken, how to tell??
Date: Fri, 12 Aug 2005 22:19:25 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <mc2pf1tgih72uq4flc3hl6q0897r060ilp@4ax.com>
References: <54nnf1tv8722aq6med3mlr4mvg7nli0r09@4ax.com> <42FC7D5E.8020604@namesys.com>
In-Reply-To: <42FC7D5E.8020604@namesys.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005 14:43:42 +0400, "Vladimir V. Saveliev" <vs@namesys.com> wrote:
>> How to test and isolate this error is in NIC driver, SATA driver or 
>> filesystem?  
>> 
>
>Could it be that tarbal on NFS server changed?
>It is not very likely that error in kernel drivers fixed typos in source code.

The 'typos' are the observed errors from extracting kernel source tarball, 
renaming top level directory and extracting tarball again.  Other times 
extraction fails with corrupt tarball error.  Cached image of tarball is 
corrupted as box doesn't go back to server.

Since first report I've changed to using ext2 target filesystem, still get 
errors, so not reiserfs specific either.  

Am in process of reducing options in kernel config, try to narrow down 
what problem is.  Nothing in logs, me have no idea ... yet.  

Not a memory error as box compiled many hundred kernels last week without 
choking.  Test just now was with 2.6.13-rc6-git3, very repeatable.

Same test on different box, no errors.  Other box has pro/100 NIC, 
reiserfs, unpack tarball from same server.  Never a problem.

Cheers,
Grant.

