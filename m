Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUF0V4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUF0V4O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 17:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUF0V4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 17:56:14 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:2054 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264499AbUF0V4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 17:56:12 -0400
Subject: Re: [PATCH] Staircase scheduler v7.4
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: kernel@kolivas.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
In-Reply-To: <200406272128.57367.mbuesch@freenet.de>
References: <200406251840.46577.mbuesch@freenet.de>
	 <200406261929.35950.mbuesch@freenet.de>
	 <1088363821.1698.1.camel@teapot.felipe-alfaro.com>
	 <200406272128.57367.mbuesch@freenet.de>
Content-Type: text/plain
Date: Sun, 27 Jun 2004 23:55:51 +0200
Message-Id: <1088373352.1691.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-27 at 21:28 +0200, Michael Buesch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Quoting Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>:
> > On Sat, 2004-06-26 at 19:29 +0200, Michael Buesch wrote:
> > 
> > > Now another "problem":
> > > Maybe it's because I'm tired, but it seems like
> > > your fix-patch made moving windows in X11 is less smooth.
> > > I wanted to mention it, just in case there's some other
> > > person, who sees this behaviour, too. In case I'm the
> > > only one seeing it, you may forget it. ;)
> > 
> > I can see the same with 7.4-1 (that's 2.6.7-ck2 plus the fix-patch): X11
> > feels sluggish while moving windows around. Simply by loading a Web page
> > into Konqueror and dragging Evolution over it, makes me able to
> > reproduce this problem.
> > 
> > Doing the same on 2.6.7-mm3 is totally smooth, however.
> 
> I think staircase-7.7 fixed this, too. (for me).
> Have a try.

Staircase 7.7 over 2.6.7-ck2 still feels somewhat sluggish... Renicing X
to -5 seems to improve a bit, but -mm3 is smoother and does not require
renicing the X server.

