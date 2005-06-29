Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVF2Qvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVF2Qvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVF2Qvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:51:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262616AbVF2Qs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:48:26 -0400
Date: Wed, 29 Jun 2005 09:47:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Zankel <chris@zankel.net>
Cc: arnd@arndb.de, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Xtensa syscalls (Was: Re: 2.6.12-rc5-mm1)
Message-Id: <20050629094739.76330344.akpm@osdl.org>
In-Reply-To: <42C2CAB8.1080402@zankel.net>
References: <20050525134933.5c22234a.akpm@osdl.org>
	<200505272313.20734.arnd@arndb.de>
	<20050528070714.GB17005@infradead.org>
	<200506291542.02618.arnd@arndb.de>
	<42C2CAB8.1080402@zankel.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Zankel <chris@zankel.net> wrote:
>
> The question is, if we had to break glibc compatibility, shouldn't we 
>  use the opportunity to clean-up the syscall list? It was copied from 
>  MIPS and, thus, has inherited a lot of legacy from there. As a new 
>  architecture, maybe we should even go as far as removing all ni-syscalls 
>  and start fresh?

If you can cope with having the syscalls renumbered then yes, that would be
good.
