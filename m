Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTKYHgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 02:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTKYHgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 02:36:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31369 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262081AbTKYHgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 02:36:23 -0500
Date: Mon, 24 Nov 2003 23:36:05 -0800
From: "David S. Miller" <davem@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lsawyer@gci.com, linux-kernel@vger.kernel.org
Subject: Re: error in Sparc64 build: kallsysms modules symbol resolution
Message-Id: <20031124233605.398dbc3e.davem@redhat.com>
In-Reply-To: <20031125072913.C53262C0EA@lists.samba.org>
References: <BF9651D8732ED311A61D00105A9CA315102CD204@berkeley.gci.com>
	<20031125072913.C53262C0EA@lists.samba.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003 14:38:37 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:

> In message <BF9651D8732ED311A61D00105A9CA315102CD204@berkeley.gci.com> you write:
> > I'm still receiving the following error message when compiling
> > for Sparc64, 2.6.0-pre10  (previously seen in -pre9)
> 
> Looks like your toolchain doesn't support weak symbols.  There are
> other ways of doing this, but weak symbols is the easiest.
> 
> This means no kallsyms for you, I'm afraid.

You really need to be using recent tools to build 2.6.x kernels
on sparc64.
