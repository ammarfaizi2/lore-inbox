Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbTBJRkJ>; Mon, 10 Feb 2003 12:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTBJRkJ>; Mon, 10 Feb 2003 12:40:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46347 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261799AbTBJRkI>; Mon, 10 Feb 2003 12:40:08 -0500
Date: Mon, 10 Feb 2003 17:49:49 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Trivial Russell <rusty@rustcorp.com.au>,
       GertJan Spoelman <kl@gjs.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59-bk4 finish job of trimming ".o" module extension in Kconfig help texts.
Message-ID: <20030210174949.A15661@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Cole <elenstev@mesatop.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rusty Trivial Russell <rusty@rustcorp.com.au>,
	GertJan Spoelman <kl@gjs.cc>, linux-kernel@vger.kernel.org
References: <1044898222.25378.890.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1044898222.25378.890.camel@localhost.localdomain>; from elenstev@mesatop.com on Mon, Feb 10, 2003 at 10:30:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 10:30:20AM -0700, Steven Cole wrote:
> In 2.5.59-bk4 in the Kconfig files, most of the instances of <module>.o
> have had the ".o" extension trimmed.  This change came from GertJan
> Spoelman through Rusty "Trivial" Russell.
> 
> However, I had some Kconfig help additions queued up through Rusty,
> which still had the ".o" extensions and which did not get trimmed.  And
> for some reason the Kconfig files in arch/s390 and arch/s390x also did
> not get trimmed.

Pah, it was useful having the .ko extension - easy to copy all the
modules from a remote build machine back to the local machine by
just giving rsync the appropriate --include and --exclude patterns.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

