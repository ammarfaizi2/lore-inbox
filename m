Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUJ1XaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUJ1XaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbUJ1X22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:28:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:23725 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263047AbUJ1X0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:26:38 -0400
Date: Thu, 28 Oct 2004 16:30:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] Fix x86-64 genapic build
Message-Id: <20041028163028.55d223fe.akpm@osdl.org>
In-Reply-To: <20041028230824.GA80511@muc.de>
References: <20041028230824.GA80511@muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> He x86-64 genapic patch that was recently merged missed some definitions
> and doesn't compile at all. 

oop.  A hasty postmortem at akpmlabs reveals that the kexec patches were
providing these definitions.  And they're identical, so all is well.

