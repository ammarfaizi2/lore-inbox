Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTJGEhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 00:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTJGEhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 00:37:11 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:53396 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S261776AbTJGEgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 00:36:02 -0400
Date: Tue, 7 Oct 2003 07:35:59 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: idt change in a running kernel? what locking?
In-Reply-To: <20031006170707.GA559@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0310070735550.3770@hosting.rdsbv.ro>
References: <Pine.LNX.4.58.0310030850110.10930@hosting.rdsbv.ro>
 <20031003063411.GF15691@mail.shareable.org> <Pine.LNX.4.58.0310030945050.10930@hosting.rdsbv.ro>
 <20031003170210.GA18415@mail.shareable.org> <Pine.LNX.4.58.0310060810440.26313@hosting.rdsbv.ro>
 <20031006170707.GA559@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Jamie Lokier wrote:

> Catalin BOIE wrote:
> > What I realy want is to reload idt on every cpu.
> > So, probably on_each_cpu is the way to go, right?
>
> Yes.  If you also want to synchronise the changes, so that all CPUs
> appear to change idt at the same instant, you'll need some extra
> locking.
>
> -- Jamie

Thanks!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
