Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUBDXUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbUBDXUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:20:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:36017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264095AbUBDXUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:20:13 -0500
Date: Wed, 4 Feb 2004 15:21:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-Id: <20040204152137.500e8319.akpm@osdl.org>
In-Reply-To: <20040204230133.GA8702@elf.ucw.cz>
References: <20040204230133.GA8702@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> It seems that some kgdb support is in 2.6.2-linus:

Lots of architectures have had in-kernel kgdb support for a long time. 
Just none of the three which I use :(

I wouldn't support inclusion of i386 kgdb until it has had a lot of
cleanup, possible de-featuritisification and some thought has been applied
to splitting it into arch and generic bits.  It's quite a lot of work.


