Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbTISS0y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 14:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbTISS0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 14:26:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:59337 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261673AbTISS0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 14:26:53 -0400
Date: Fri, 19 Sep 2003 11:07:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: irq 11: nobody cared! is back
Message-Id: <20030919110749.7d24e1d4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0309190951340.29744@montezuma.fsmlabs.com>
References: <3F6B0671.1070603@jtholmes.com>
	<Pine.LNX.4.53.0309190951340.29744@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> On Fri, 19 Sep 2003, jtholmes wrote:
> 
> > I don't take the  Distribution, and don't need email copy of
> > answer,  just  answer in LKML  and I will see it.
> 
> boot with the 'noirqdebug' kernel parameter

That'll probably just make the box lock up.

Something seems to have gone wrong with uhci-hcd, failing to clear an
interrupt source perhaps.

