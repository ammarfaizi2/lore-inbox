Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTEHTo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbTEHTo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:44:58 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:44469 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261936AbTEHTo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:44:58 -0400
Date: Thu, 8 May 2003 15:27:30 -0400
From: Ben Collins <bcollins@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "David S. Miller" <davem@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030508192730.GX679@phunnypharm.org>
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz> <20030507135600.A22642@infradead.org> <1052318339.9817.8.camel@rth.ninka.net> <20030508151643.GO679@phunnypharm.org> <20030508193430.GC933@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508193430.GC933@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 09:34:30PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This would also solve the current problem where a module that is
> > compiled with compat ioctl's using register_ioctl32_conversion() is not
> > usable on a kernel compiled without CONFIG_COMPAT, even though it very
> > well should be.
> 
> CONFIG_COMPAT is pretty much constant depending only on
> architecture. I see no point in complicating this.

I don't think so. Sparc64 and ia64 I know allow you to disable 32bit
compatibility. I'd be surprised if the other 32/64 architectures didn't.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
