Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWAFAfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWAFAfy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWAFAfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:35:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41607 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932333AbWAFAfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:35:53 -0500
Date: Thu, 5 Jan 2006 16:35:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm1: what's page_owner.c doing in Documentation/ ???
Message-Id: <20060105163532.4307672c.akpm@osdl.org>
In-Reply-To: <9a8748490601051624u36fb03d2l349c40a0165cbddb@mail.gmail.com>
References: <9a8748490601051624u36fb03d2l349c40a0165cbddb@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> Just wondering what page_owner.c is doing in Documentation/ in 2.6.15-mm1 ;-)
> 
> $ ls -l linux-2.6.15-mm1/Documentation/page_owner.c
> -rw-r--r--  1 juhl users 2587 2006-01-05 18:15
> linux-2.6.15-mm1/Documentation/page_owner.c
> 

That's the tool for extracting the data which
page-owner-tracking-leak-detector.patch produces.  There's no obvious place
to put it, really.  It could be in scripts/ I guess.

Consider it compilable documentation ;)

