Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135527AbREBO7K>; Wed, 2 May 2001 10:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135545AbREBO6u>; Wed, 2 May 2001 10:58:50 -0400
Received: from ns.suse.de ([213.95.15.193]:9231 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135527AbREBO6j>;
	Wed, 2 May 2001 10:58:39 -0400
Date: Wed, 2 May 2001 16:58:16 +0200
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Paul J Albrecht <pjalbrecht@home.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Debuggers, KDB or KGDB?
Message-ID: <20010502165816.A8450@gruyere.muc.suse.de>
In-Reply-To: <01043016264000.00697@CB57534-A> <18223.988679810@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <18223.988679810@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, May 01, 2001 at 11:16:50AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 11:16:50AM +1000, Keith Owens wrote:
> My ideal debugger is one that combines the internal knowledge of kdb
> with the source level debugging of gdb.  I know how to do this over a
> serial line, finding time to write the code is the problem.

http://pice.sourceforge.net is one approach to it; but it's currently
a bit limited: e.g. ATM UP-i386-2.2 only and somewhat windowish; also the
approach only really works for modules not complete kernel sources unless
you have a *lot* of memory. Still in its limits it works.

-Andi
