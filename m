Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270367AbUJTW76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270367AbUJTW76 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270348AbUJTWaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:30:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269152AbUJTW1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:27:05 -0400
Date: Wed, 20 Oct 2004 15:30:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Structural changes for Documentation directory
Message-Id: <20041020153058.6de41ed8.akpm@osdl.org>
In-Reply-To: <4176CFE3.2030306@verizon.net>
References: <4176CFE3.2030306@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Nelson <james4765@verizon.net> wrote:
>
> I propose changing the structure of the Documentation directory to 
> reflect the structure of the kernel sources itself.

That sounds like a bit of overdesign, really.  Take it one step at a time.

Sure, if you're really prepared to do a large-scale overhaul then the first
step is to create a new top-level directory, say
"./non-crappy-Documentation" and then move files over into there as they
are fixed up.  That way we have a good handle on what is done and what
remains.  You can then make decisions about the directory structure
on an incremental basis as you become more familiar with the problem.

> Perhaps it would be best to put the new tree in place and have the 
> individual maintainers relocate their documentation to the new 
> structure?

Maintainers studiously ignore the Documentation directory.  If someone
really wishes to get in there and fix it all up, that person gets to decide
what goes where and that person gets to harrass various other maintainers
when assistance is needed.

