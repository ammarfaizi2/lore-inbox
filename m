Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVCLA0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVCLA0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVCLA0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 19:26:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:53481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261542AbVCLA0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 19:26:34 -0500
Date: Fri, 11 Mar 2005 16:23:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adam Belay <abelay@novell.com>
Cc: bunk@stusta.de, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/pnp/: possible cleanups
Message-Id: <20050311162320.15007aa3.akpm@osdl.org>
In-Reply-To: <1110585763.12485.223.camel@localhost.localdomain>
References: <20050311181606.GC3723@stusta.de>
	<1110585763.12485.223.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay <abelay@novell.com> wrote:
>
> This patch essential makes it impossible for PnP protocols to be
> modules.  Currently, they are all in-kernel.  If that is acceptable...,
> then this patch looks fine to me.  Any comments?

You're the maintainer...

If someone converts a protocol to be moduar, presumably they will re-add
the needed exports to support that.

Are there likely to be any out-of-tree modular protocols in existence?

