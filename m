Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUFEVxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUFEVxy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUFEVxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:53:54 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:26281 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262085AbUFEVxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:53:53 -0400
Date: Sat, 5 Jun 2004 14:53:46 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
Message-ID: <20040605215346.GB29525@taniwha.stupidest.org>
References: <40C1E6A9.3010307@elegant-software.com> <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <20040605205547.GD20716@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040605205547.GD20716@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2004 at 10:55:47PM +0200, Arjan van de Ven wrote:

> ... or glibc internally caches the getpid() result and doesn't
> notice the app calls clone() internally... strace seems to show 1
> getpid() call total not 2.

glibc caches getpid() ?!?

it's not like it's a slow syscall or used often


  --cw

