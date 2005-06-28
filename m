Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVF1GkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVF1GkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVF1Gjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:39:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261645AbVF1GhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:37:15 -0400
Date: Mon, 27 Jun 2005 23:36:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1 keyboard oddities
Message-Id: <20050627233639.470a5ba9.akpm@osdl.org>
In-Reply-To: <200506242035.18902.bero@arklinux.org>
References: <200506242035.18902.bero@arklinux.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
> Hi,
> after applying Dipankar Sarma's patch for the fcntl64 Oops, 2.6.12-mm1 works 
> nicely here (x86). One oddity: If I don't "loadkeys anything", only the very 
> basic keys work, all F* keys etc. are dead.
> 
> Is this an intentional change to force people to do the right thing and load 
> some keymap, or a bug?

Well I stubbed out /bin/loadkeys here, booted 2.6.12-mm2++ and stuff comes
out when I hit F1.  Does it still happen there?  If so, can you send the
.config?

