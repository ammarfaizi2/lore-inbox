Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTKDASL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 19:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTKDASL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 19:18:11 -0500
Received: from rth.ninka.net ([216.101.162.244]:26753 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263529AbTKDASL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 19:18:11 -0500
Date: Mon, 3 Nov 2003 17:14:45 -0800
From: "David S. Miller" <davem@redhat.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: liste@jordet.nu, akpm@osdl.org, jt@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: Oops at "NET: Registering protocol family 23" at boot with
 2.6.0t9-bk
Message-Id: <20031103171445.0fdee8c6.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0311021020200.29973-100000@notebook.home.mdiehl.de>
References: <1067705386.666.1.camel@chevrolet.hybel>
	<Pine.LNX.4.44.0311021020200.29973-100000@notebook.home.mdiehl.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003 00:27:00 +0100 (CET)
Martin Diehl <lists@mdiehl.de> wrote:

> On Sat, 1 Nov 2003, Stian Jordet wrote:
> 
> > NET: Registered protocol family 23
> > Unable to handle kernel NULL pointer dereference at virtual address 00000004
> > EIP is at dev_add_pack+0x4d/0xb0
> 
> which is at "next->prev = new" in __list_add_rcu()

This bug is already fully analyzed, please read the rest of the
thread.  Andrew's change which introduced this problem will be
reverted.
