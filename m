Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268864AbUJTTwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268864AbUJTTwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270486AbUJTTtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:49:31 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:59816 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268864AbUJTTmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:42:50 -0400
Date: Wed, 20 Oct 2004 12:42:36 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] add hook to generic irq code (free_irq)
Message-ID: <20041020194236.GA11881@taniwha.stupidest.org>
References: <20041020023156.GA8597@taniwha.stupidest.org> <20041020130715.GA20287@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020130715.GA20287@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 02:07:15PM +0100, Christoph Hellwig wrote:

> This looks rather bogus to me.  What prevents UML from doing it's work
> at the struct hw_interrupt_type level?

Probably nothing, it's just not clear to me how that would work or
should look.  Let me poke about and see if I can figure it out.
