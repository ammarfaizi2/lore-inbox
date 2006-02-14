Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWBNCvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWBNCvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 21:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWBNCvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 21:51:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750875AbWBNCvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 21:51:15 -0500
Date: Mon, 13 Feb 2006 18:50:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: lee.schermerhorn@hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16-rc2-mm1 -
 repair-ipc-semaphore-comments-and-variables
Message-Id: <20060213185019.539bd916.akpm@osdl.org>
In-Reply-To: <1139843280.5381.2.camel@localhost.localdomain>
References: <1139843280.5381.2.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Schermerhorn <lee.schermerhorn@hp.com> wrote:
>
> An apparent global find/replace of 'semphore' to 'mutex' in ipc/sem.c
>  modified several comments and variables that refer to the so called
>  "SysV IPC semphores".  The user interface objects remain "semaphores". 
>  The name of the file is still 'ipc/sem.c' This patch attempts to revert
>  just those comments and variables that refer to the "SysV IPC
>  semphores".

heh, yes, thanks.

The patch had significant wordwrapping - please fix that email client for
next time.

>  Note that several of these comments contain 10+ year old revision notes
>  that could possibly be removed at some time.

Sure, a comment review & revamp wouldn't hurt.
