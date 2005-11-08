Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965367AbVKHCgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965367AbVKHCgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965675AbVKHCgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:36:08 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:62083 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965367AbVKHCgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:36:06 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Dick <dm@chello.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: SIGALRM ignored 
In-reply-to: Your message of "Mon, 07 Nov 2005 17:36:29 -0000."
             <loom.20051107T183059-826@post.gmane.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Nov 2005 13:35:56 +1100
Message-ID: <7841.1131417356@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005 17:36:29 +0000 (UTC), 
Dick <dm@chello.nl> wrote:
>I've got a problem with SUSE LINUX Enterprise Server 9 (i586) patchlevel 2,
>Linux 2.6.5-7.191-smp.
>
>When I do the following (from bash):
>
>trap 'echo bla' 14 ; /bin/kill -14 $$
>
>nothing happens, utilities like iostat and netperf (and likely other utilities)
>won't work due to this problem.

Works for me on SLES9 SP2 ia64.

Linux chook 2.6.5-7.191-sn2 #1 SMP Tue Jun 28 14:58:56 UTC 2005 ia64 ia64 ia64 GNU/Linux
bash-2.05b-305.9

# trap 'echo bla' 14 ; /bin/kill -14 $$
bla

