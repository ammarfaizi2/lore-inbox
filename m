Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWJBU5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWJBU5N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWJBU5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:57:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10417 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965107AbWJBU5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:57:11 -0400
Date: Mon, 2 Oct 2006 13:56:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "David Howells" <dhowells@redhat.com>,
       "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, "Greg KH" <greg@kroah.com>,
       "David Brownell" <david-b@pacbell.net>,
       "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
Message-Id: <20061002135648.9250b51d.akpm@osdl.org>
In-Reply-To: <d120d5000610021343h45bf1414ica2246f3b10ff46d@mail.gmail.com>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	<20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	<20061002132116.2663d7a3.akpm@osdl.org>
	<d120d5000610021343h45bf1414ica2246f3b10ff46d@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006 16:43:38 -0400
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> >
> > I think the change is good.  But I don't want to maintain this whopper
> > out-of-tree for two months!  If we want to do this, we should just smash it
> > in and grit our teeth.
> 
> Yes, lets drop it in while we still not reached rc1.

Doing it after -rc1 would be saner, when the tree isn't changing at a
megabyte-per-minute.  Give people at least a couple of days to review it,
test it, etc.
