Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTGCTRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbTGCTRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:17:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263990AbTGCTRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:17:48 -0400
Date: Thu, 3 Jul 2003 12:26:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1: kernel BUG@include/linux/list.h:148
Message-Id: <20030703122638.611e72ac.akpm@osdl.org>
In-Reply-To: <200307032340.50406.kernel@kolivas.org>
References: <200307032340.50406.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Got this on bootup with devfs and preempt enabled.
> 
> ------------[ cut here ]------------
> kernel BUG at include/linux/list.h:148!

grr, where's my smalldevfs?

You can just revert list_del-debug.patch if it's being a hassle.
