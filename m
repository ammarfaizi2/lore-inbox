Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUCILJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUCILJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:09:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:19116 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261870AbUCILI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:08:57 -0500
Date: Tue, 9 Mar 2004 03:09:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: andrea@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to
 avoid 4:4 in <=16G machines)
Message-Id: <20040309030907.71a53a7c.akpm@osdl.org>
In-Reply-To: <20040309110233.GA3819@elte.hu>
References: <20040308202433.GA12612@dualathlon.random>
	<20040309105226.GA2863@elte.hu>
	<20040309110233.GA3819@elte.hu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> or run the attached test-mmap2.c code, which simulates a very small DB
>  app using only 1800 vmas per process: it only maps 8 MB of shm and
>  spawns 32 processes. This has an even more lethal effect than the
>  previous code.

Do these tests actually make any forward progress at all, or is it some bug
which has sent the kernel into a loop?

