Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265411AbTLSALw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 19:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265413AbTLSALw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 19:11:52 -0500
Received: from rth.ninka.net ([216.101.162.244]:4737 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S265411AbTLSALv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 19:11:51 -0500
Date: Thu, 18 Dec 2003 16:11:47 -0800
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: Kernel 2.6.0 small fixes
Message-Id: <20031218161147.11bb99b4.davem@redhat.com>
In-Reply-To: <20031218214426.GA16223@devserv.devel.redhat.com>
References: <20031218214426.GA16223@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003 16:44:26 -0500
Alan Cox <alan@redhat.com> wrote:

> -		printk(KERN_ERR " cdsize = 0x%lx (expected 0x%lx)\n",
> +		printk(KERN_ERR " cdsize = 0x%x (expected 0x%x)\n",

At least one of these wants size_t, so use %Zx or similar.
