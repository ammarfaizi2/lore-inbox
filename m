Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUBUAJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbUBUAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:09:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:54955 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261440AbUBUAJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:09:47 -0500
Subject: Re: Fix silly thinko in sungem network driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "David S. Miller" <davem@redhat.com>
In-Reply-To: <200402202307.i1KN7GBR003938@hera.kernel.org>
References: <200402202307.i1KN7GBR003938@hera.kernel.org>
Content-Type: text/plain
Message-Id: <1077321849.9719.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 11:04:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-21 at 09:29, Linux Kernel Mailing List wrote:
> ChangeSet 1.1584, 2004/02/20 14:29:11-08:00, torvalds@ppc970.osdl.org
> 
> 	Fix silly thinko in sungem network driver.
> 	

Argh. Actually, the patch is wrong as we are losing the 2 other
magic bits (the RonPaul bit, dunno what it is, that's how it's
called by Apple, end the other bugfix bit, some more apple magic).

Fixed patch on its way ... (as soon as I finish pulling, don't
cancel that cset, I'll apply a patch on top of it)

Ben.

