Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVEBXr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVEBXr6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 19:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVEBXr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 19:47:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:40599 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261234AbVEBXr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 19:47:57 -0400
Date: Mon, 2 May 2005 16:45:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2: fs/proc/task_mmu.c warnings
Message-Id: <20050502164501.50187481.akpm@osdl.org>
In-Reply-To: <3f250c7105050216357ae31105@mail.gmail.com>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<20050501222916.GB3592@stusta.de>
	<3f250c7105050215306de620ac@mail.gmail.com>
	<3f250c7105050216357ae31105@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Lin <mauriciolin@gmail.com> wrote:
>
> I managed to replicate the warning. This happens with the vanilla
> kernel 2.6.11.8. Before this version this warning does not exist. The
> last patch I posted was based on 2.6.11.7. I am going to post the new
> patch asap.

Please don't generate patches for the mainline kernel against the -stable
tree.  2.6.11.7 is ancient - we've added 22MB of diff since then.

I think I've fixed all the /proc/pid/smaps problems anwyay.
