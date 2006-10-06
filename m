Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422715AbWJFWoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWJFWoA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWJFWoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:44:00 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:22228 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1422715AbWJFWn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:43:59 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: caszonyi@rdslink.ro, ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Merge window closed: v2.6.19-rc1
Date: Sat, 07 Oct 2006 08:43:52 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <8omdi212peo1uph0c1t6tvt41grfoqfkdp@4ax.com>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <Pine.LNX.4.62.0610062041440.1966@grinch.ro> <Pine.LNX.4.64.0610061110050.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610061110050.3952@g5.osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 11:12:10 -0700 (PDT), Linus Torvalds <torvalds@osdl.org> wrote:

>
>
>On Fri, 6 Oct 2006, caszonyi@rdslink.ro wrote:
>> 
>> In dmesg:
>> warning: process `sleep' used the removed sysctl system call
>> warning: process `alsactl' used the removed sysctl system call
>> warning: process `nscd' used the removed sysctl system call
>> warning: process `tail' used the removed sysctl system call
>
>You need to compile with CONFIG_SYSCLT set to 'y' rather than 'n'.
>
>Alternatively, you can probably fix it by just upgrading user-land, but 
>the SYSCLT thing _does_ still exist, it's just deprecated and defaults to 
>off by default..
>
>(Or you can possibly even choose to just ignore the warnings, they 
>probably won't affect any actual behaviour)

I get these:
grant@sempro:~$ dmesg |grep removed
warning: process `touch' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
warning: process `dd' used the removed sysctl system call
warning: process `ls' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call

too, box still works, slack-11.0 if it matters.

Grant.
