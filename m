Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262990AbVG3Pnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbVG3Pnt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 11:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVG3Pnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 11:43:49 -0400
Received: from graphe.net ([209.204.138.32]:36285 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262986AbVG3Pnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 11:43:42 -0400
Date: Sat, 30 Jul 2005 08:43:37 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/4] Task notifier against mm: Implement todo list in
 task_struct
In-Reply-To: <20050730112241.GA1830@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0507300843100.24809@graphe.net>
References: <Pine.LNX.4.62.0507291328170.5304@graphe.net>
 <Pine.LNX.4.62.0507291332100.5304@graphe.net> <20050730112241.GA1830@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005, Pavel Machek wrote:

> No wonder when -mm already contains:
> 
> /*
>  * Check if there is a request to freeze a process
>  */
> static inline int freezing(struct task_struct *p)
> {
>         return test_ti_thread_flag(p->thread_info, TIF_FREEZE);
> }

Yes I told you to remove the TIF_FREEZE patch.

