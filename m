Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbTI2VtF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbTI2VtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:49:05 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:52570 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263061AbTI2VtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:49:03 -0400
Date: Mon, 29 Sep 2003 17:48:56 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Daniel Jacobowitz <dan@debian.org>, Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Brian Gerst <bgerst@didntduck.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: -mregparm=3 (was  Re: [PATCH] i386 do_machine_check() is redundant.
Message-ID: <20030929174856.U11756@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org> <1064775868.5045.4.camel@laptop.fenrus.com> <Pine.LNX.4.58.0309292214100.3276@artax.karlin.mff.cuni.cz> <20030929202604.GA23344@nevyn.them.org> <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0309292309050.7824@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Mon, Sep 29, 2003 at 11:36:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 11:36:06PM +0200, Mikulas Patocka wrote:
> > It's interesting for kernel code, whole distributions, or things which
> > are careful to have a glue layer.
> 
> BTW. libc headers surround all function parameters with __P, like
> extern int printf __P ((__const char* __format, ...));

s/surround/used to &/

	Jakub
