Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbUKIIQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUKIIQH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 03:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbUKIIQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 03:16:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:11681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261433AbUKIIQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 03:16:06 -0500
Date: Tue, 9 Nov 2004 00:15:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: tj@home-tj.org, mingo@elte.hu, diffie@gmail.com,
       linux-kernel@vger.kernel.org, diffie@blazebox.homeip.net,
       alan@lxorguk.ukuu.org.uk, Andries.Brouwer@cwi.nl
Subject: Re: 2.6.10-rc1-mm3
Message-Id: <20041109001552.4465c23f.akpm@osdl.org>
In-Reply-To: <20041109080509.GA10724@kroah.com>
References: <9dda349204110611043e093bca@mail.gmail.com>
	<20041107024841.402c16ed.akpm@osdl.org>
	<20041108075934.GA4602@elte.hu>
	<20041107234225.02c2f9b6.akpm@osdl.org>
	<20041108224259.GA14506@kroah.com>
	<20041108212747.33b6e14a.akpm@osdl.org>
	<20041109071455.GA11643@kroah.com>
	<20041109080509.GA10724@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> Andrew, does the patch below fix the issue for you?  It fixed my test
>  case.

Dunno - I can't configure 512 legacy ptys any more ;)

>   		if (parent)
>   			kobject_put(parent);

kobject_put(NULL) is legal...
