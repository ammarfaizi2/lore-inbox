Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbTAJQGU>; Fri, 10 Jan 2003 11:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTAJQGT>; Fri, 10 Jan 2003 11:06:19 -0500
Received: from air-2.osdl.org ([65.172.181.6]:49614 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265270AbTAJQGP>;
	Fri, 10 Jan 2003 11:06:15 -0500
Date: Fri, 10 Jan 2003 09:22:21 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: <louis.zhuang@linux.co.intel.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Bug fix] delete kobject from list when kobject_add() fail
In-Reply-To: <32860.172.16.219.159.1042191045.squirrel@linux.intel.com>
Message-ID: <Pine.LNX.4.33.0301100921070.1015-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Jan 2003 louis.zhuang@linux.co.intel.com wrote:

> Dear Mochel,
> 	I found there were still issues in failed kobject_add(). For example,
> if you try to register two kobjects with the same name into
> subsystem, the second registration will fail but the second will keep in
> the list of subsystem. Below patch might fix the bug. Please  apply.

Thanks. I applied it, though slightly modified (I detest function names
with the '__' prefix). :)

	-pat

