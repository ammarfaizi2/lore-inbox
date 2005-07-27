Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVG0Wzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVG0Wzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVG0Wxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:53:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261182AbVG0WwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:52:19 -0400
Date: Wed, 27 Jul 2005 15:51:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: ebiederm@xmission.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
Message-Id: <20050727155118.6d67d48e.akpm@osdl.org>
In-Reply-To: <20050727224711.GA6671@elf.ucw.cz>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
	<m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
	<20050727104123.7938477a.akpm@osdl.org>
	<m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
	<20050727224711.GA6671@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
>  > Good question.  I'm not certain if Pavel intended to add
>  > device_suspend(PMSG_FREEZE) to the reboot path.  It was
>  > there in only one instance.  Pavel comments talk only about
>  > the suspend path.
> 
>  Yes, I think we should do device_suspend(PMSG_FREEZE) in reboot path.

Why?
