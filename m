Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266911AbUBMK5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266917AbUBMK5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:57:33 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:6017 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S266911AbUBMK52 (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 13 Feb 2004 05:57:28 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16428.44433.503851.536857@laputa.namesys.com>
Date: Fri, 13 Feb 2004 13:57:21 +0300
To: "Cheng" <geek@geekbone.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>
Subject: Re: Fw: [Bug 2084] New: Reiserfs causes sytem hang
In-Reply-To: <20040212184352.59ef8d7f.akpm@osdl.org>
References: <20040212184352.59ef8d7f.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > 
 > http://bugme.osdl.org/show_bug.cgi?id=2084
 > 
 >            Summary: Reiserfs causes sytem hang
 >     Kernel Version: 2.6.2
 >             Status: NEW
 >           Severity: high
 >              Owner: reiserfs-dev@namesys.com
 >          Submitter: geek@geekbone.org
 > 
 > 
 > Distribution: 
 > Debian Sarge
 > 
 > Hardware Environment: 
 > Whitebox P4 Xeon server with Tyan S2723 Motherboard and 3ware 7506 Raid 5 card
 > 
 > Software Environment: 
 > self compiled plain Kernel 2.6.2
 > Reiserfs
 > Raid 5
 > 
 > Problem Description: 
 > rsync was running as scheduled in cron normally and system suddenly hang up 
 > with the following kernel message.

Hello, Cheng,

were there any other error/warning messages in the log just before BUG?

 > 
 > ------------[ cut here ]------------
 > kernel BUG at fs/reiserfs/namei.c:1198!
 > invalid operand: 0000 [#1]
 > CPU:    1
 > EIP:    0060:[<c01ac359>]    Not tainted
 > EFLAGS: 00010297
 > EIP is at reiserfs_rename+0x2ec/0xaa9
 > eax: 00000000   ebx: f0d81680   ecx: d66c7e50   edx: 00000000
 > esi: 00000000   edi: d66c7d10   ebp: ccad0338   esp: d66c7c58

Nikita.
