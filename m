Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbUJ3RZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbUJ3RZa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 13:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUJ3RZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 13:25:11 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:36366 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP id S261218AbUJ3RZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 13:25:06 -0400
Date: Sat, 30 Oct 2004 19:24:50 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: dap <dap@kenyer.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1 crashes on recursive directory walk [2.6.9 was OK]
Message-ID: <20041030172450.GA1834@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <1099156115.14842.322.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099156115.14842.322.camel@localhost>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: dap <dap@kenyer.hu>
Date: Sat, Oct 30, 2004 at 07:08:36PM +0200
> 
>  I've used xfs and ext3 on a large ftp server with lots of files, and
> when I do a 'find / -ls' with the kernel 2.6.10-rc1, the server crashes
> with no Oops or other message. only the reset button give a response.. I
> can reproduce it any time with find, but the point of crash is random,
> it can crash on xfs and ext3 partitions too..  2.6.9 works fine in this
> environment..
> 
What are the tailing lines of 'strace find / -ls' ? 

Those would perhaps help determine what system call is crashing.

Jurriaan
-- 
"It shall not happen again, not while I am alive." Nion struck his chest
with his fist. "I have been mild and guileless! I have trusted persons
with suppuration and gangrene for brains."
	Jack Vance - Araminta Station
Debian (Unstable) GNU/Linux 2.6.9-mm1 2x6078 bogomips load 0.25
