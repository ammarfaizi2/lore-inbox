Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270425AbUJTDWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270425AbUJTDWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 23:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270407AbUJTDWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 23:22:32 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:28043 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270427AbUJTDSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 23:18:51 -0400
Date: Tue, 19 Oct 2004 20:18:26 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@karaya.com>,
       linux-kernel@vger.kernel.org
Subject: Re: generic hardirq handling for uml
Message-ID: <20041020031826.GA9966@taniwha.stupidest.org>
References: <20041020001124.GA29215@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020001124.GA29215@admingilde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 02:11:24AM +0200, Martin Waitz wrote:

> I just ported arch/um to generic hardirq handling.

heh, i posted something similat too

> -void free_irq(unsigned int irq, void *dev_id)
[...]
> -			free_irq_by_irq_and_dev(irq, dev_id);

that is actually needed and missing from the generic code, if you run
w/o this you will get funnies won't you?
