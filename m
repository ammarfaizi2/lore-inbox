Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWDBWjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWDBWjp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWDBWjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:39:45 -0400
Received: from morbo.e-centre.net ([66.154.82.3]:26357 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP
	id S1751474AbWDBWjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:39:44 -0400
X-ASG-Debug-ID: 1144017583-1444-39-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: Who wants to test cracklinux??
Subject: Re: Who wants to test cracklinux??
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Ford <ben@kalifornia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44305193.5080408@kalifornia.com>
References: <20060328221223.80753cab.letterdrop@gmx.de>
	 <20060328224929.GC5760@elf.ucw.cz>  <44305193.5080408@kalifornia.com>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 00:39:41 +0200
Message-Id: <1144017581.3066.34.camel@testmachine>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10393
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-02 at 15:34 -0700, Ben Ford wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Pavel Machek wrote:
> > Hi!
> >> I've written a small kernel module & shared object for kernel 2.6 to
> >> enable the following for normal users:
> >>
> >> - inb()/outb()... via a wrapper function
> > ioperm() does that already, no? You mean, you enable it for non-root,
> > too? That's security hole.
> 
> My OS development classes have a lab of machines that run entirely as
> root just for these reasons.  I think it's valid to allow these
> operations as non-root in certain situations.  It is better than
> running *everything* as root, no?

is there any difference? I mean... if you can outb you for all intents
and purposes are root anyway ;) (like you can overwrite any memory in
the system etc etc)

