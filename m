Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUJGTbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUJGTbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUJGT3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:29:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7552 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267918AbUJGT1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:27:40 -0400
Date: Thu, 7 Oct 2004 15:27:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Probable module bug in linux-2.6.5-1.358
In-Reply-To: <1097175903.29576.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0410071522550.3647@chaos.analogic.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
 <1097175903.29576.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Stephen Hemminger wrote:

[SNIPPED...]


> If you can reproduce the same problem with some GPL version of
> standalone (even dummy) code, then come back and see us sometime.
>

Best I can see in the sources, the only place cd_forget() (for
removing a character device) is called is from clear_inode()
in inode.c. This is never called by unregister_chrdev().



Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

