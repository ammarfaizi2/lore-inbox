Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTEHTX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTEHTX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:23:56 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:9447 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262037AbTEHTXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:23:55 -0400
Date: Thu, 8 May 2003 21:34:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ben Collins <bcollins@debian.org>
Cc: "David S. Miller" <davem@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030508193430.GC933@elf.ucw.cz>
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz> <20030507135600.A22642@infradead.org> <1052318339.9817.8.camel@rth.ninka.net> <20030508151643.GO679@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508151643.GO679@phunnypharm.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This would also solve the current problem where a module that is
> compiled with compat ioctl's using register_ioctl32_conversion() is not
> usable on a kernel compiled without CONFIG_COMPAT, even though it very
> well should be.

CONFIG_COMPAT is pretty much constant depending only on
architecture. I see no point in complicating this.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
