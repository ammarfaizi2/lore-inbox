Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTEHUNr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 16:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbTEHUNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 16:13:47 -0400
Received: from palrel12.hp.com ([156.153.255.237]:29356 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262095AbTEHUNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 16:13:46 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16058.48490.620518.27093@napali.hpl.hp.com>
Date: Thu, 8 May 2003 13:26:18 -0700
To: Ben Collins <bcollins@debian.org>
Cc: Pavel Machek <pavel@ucw.cz>, "David S. Miller" <davem@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
In-Reply-To: <20030508192730.GX679@phunnypharm.org>
References: <20030507104008$12ba@gated-at.bofh.it>
	<200305071154.h47BsbsD027038@post.webmailer.de>
	<20030507124113.GA412@elf.ucw.cz>
	<20030507135600.A22642@infradead.org>
	<1052318339.9817.8.camel@rth.ninka.net>
	<20030508151643.GO679@phunnypharm.org>
	<20030508193430.GC933@elf.ucw.cz>
	<20030508192730.GX679@phunnypharm.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 8 May 2003 15:27:30 -0400, Ben Collins <bcollins@debian.org> said:

  Ben> On Thu, May 08, 2003 at 09:34:30PM +0200, Pavel Machek wrote:
  >> Hi!

  >> > This would also solve the current problem where a module that
  >> is > compiled with compat ioctl's using
  >> register_ioctl32_conversion() is not > usable on a kernel
  >> compiled without CONFIG_COMPAT, even though it very > well should
  >> be.

  >> CONFIG_COMPAT is pretty much constant depending only on
  >> architecture. I see no point in complicating this.

  Ben> I don't think so. Sparc64 and ia64 I know allow you to disable
  Ben> 32bit compatibility. I'd be surprised if the other 32/64
  Ben> architectures didn't.

Definitely.  I turn it off on a regular basis and expect to use it
even less in the future.

	--david
