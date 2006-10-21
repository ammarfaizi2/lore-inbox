Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992757AbWJUAcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992757AbWJUAcj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992756AbWJUAci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:32:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992753AbWJUAch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:32:37 -0400
Date: Fri, 20 Oct 2006 17:32:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Enforce "unsigned long flags;" when spinlocking
Message-Id: <20061020173233.ad9fcda8.akpm@osdl.org>
In-Reply-To: <20061020233803.GA5344@martell.zuzino.mipt.ru>
References: <20061020131544.GC17199@martell.zuzino.mipt.ru>
	<20061020114640.9231b18f.akpm@osdl.org>
	<20061020233803.GA5344@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2006 03:38:03 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> > If we're going to do this then a helper macro build_check_irq_flags() would
> > help clean things up.  It will also allow us to centralise the
> > warning-vs-error policy decision.
> 
> I will find a common header. kernel.h probably.

irqflags.h sounds more appropriate.
