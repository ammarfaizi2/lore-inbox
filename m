Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbTLaLWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 06:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265259AbTLaLWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 06:22:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:40850 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265253AbTLaLWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 06:22:48 -0500
Date: Wed, 31 Dec 2003 03:23:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lennert Buytenhek <buytenh@gnu.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.6.0-mm2] slab corruption during packet flood on e100
Message-Id: <20031231032313.049c52d7.akpm@osdl.org>
In-Reply-To: <20031231105227.GA9429@gnu.org>
References: <20031231105227.GA9429@gnu.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek <buytenh@gnu.org> wrote:
>
> When routing a large stream of UDP packets through this machine, coming
>  in on eth1 (e100), headed towards dummy0, I get a flood of slab corruption
>  messages a la below.  Box is a 2-way HT SMP machine.
> 
>  Is this a known problem with the e100 driver perhaps?

The experimental net driver tree has what appears to be a big e100 rewrite
in it.  Can you test 2.6.1-rc1 sometime?

