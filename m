Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTKYH3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 02:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTKYH3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 02:29:14 -0500
Received: from dp.samba.org ([66.70.73.150]:58520 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262078AbTKYH3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 02:29:14 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Leif Sawyer <lsawyer@gci.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: error in Sparc64 build: kallsysms modules symbol resolution 
In-reply-to: Your message of "Mon, 24 Nov 2003 16:37:35 -0900."
             <BF9651D8732ED311A61D00105A9CA315102CD204@berkeley.gci.com> 
Date: Tue, 25 Nov 2003 14:38:37 +1100
Message-Id: <20031125072913.C53262C0EA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <BF9651D8732ED311A61D00105A9CA315102CD204@berkeley.gci.com> you write:
> I'm still receiving the following error message when compiling
> for Sparc64, 2.6.0-pre10  (previously seen in -pre9)

Looks like your toolchain doesn't support weak symbols.  There are
other ways of doing this, but weak symbols is the easiest.

This means no kallsyms for you, I'm afraid.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
