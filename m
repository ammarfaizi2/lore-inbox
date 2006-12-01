Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161994AbWLAVrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161994AbWLAVrf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162012AbWLAVrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:47:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161994AbWLAVre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:47:34 -0500
Date: Fri, 1 Dec 2006 13:47:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Emelianov <xemul@openvz.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixed formatting in ia64_process_pending_irq()
Message-Id: <20061201134732.aa1c597a.akpm@osdl.org>
In-Reply-To: <45702037.1030701@openvz.org>
References: <45702037.1030701@openvz.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2006 15:29:43 +0300
Pavel Emelianov <xemul@openvz.org> wrote:

> A trivial issue found during code examining.
> Someone typed unneeded extra spaces.

It's the usual mess in there.

akpm:/usr/src/linux-2.6.19> grep -r '^    ' arch/ia64 | wc -l           
341

There isn't much point in fixing just four of them.
