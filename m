Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274984AbTHFWi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274979AbTHFWhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:37:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:64176 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274967AbTHFWgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:36:44 -0400
Date: Wed, 6 Aug 2003 15:38:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cardbus suspend/resume of 3ccfe575bt card fails
Message-Id: <20030806153829.7c4c4528.akpm@osdl.org>
In-Reply-To: <20030806232735.I16116@flint.arm.linux.org.uk>
References: <20030806232735.I16116@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> wrote:
>
> It looks like 3c59x only saves the PCI config space and restores it if
>  you have WOL enabled - this is obviously wrong if you're suspending/
>  resuming a CardBus device.

yup.  I always meant to turn on the 3c59x PM code as soon as 2.5 started,
but forgot.  It happened only last week.

Current -linus should get it right.  I have a card round here somewhere and
will check it over.

