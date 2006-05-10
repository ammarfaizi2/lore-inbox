Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWEJWK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWEJWK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWEJWK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:10:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41952 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965039AbWEJWK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:10:28 -0400
Date: Wed, 10 May 2006 23:10:24 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: dwalker@mvista.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060510221024.GH27946@ftp.linux.org.uk>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com> <1147257266.17886.3.camel@localhost.localdomain> <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net> <1147273787.17886.46.camel@localhost.localdomain> <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net> <1147275571.17886.64.camel@localhost.localdomain> <1147275522.21536.109.camel@c-67-180-134-207.hsd1.ca.comcast.net> <20060510162106.GC27946@ftp.linux.org.uk> <20060510150321.11262b24.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510150321.11262b24.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 03:03:21PM -0700, Andrew Morton wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> >
> > Don't.  Fix.  Correct.  Code.
> > 
> >  Ever.  Because sooner or later you will paper over real bug.
> 
> I occasionally receive patches which generate new warnings, and those
> warnings flag real bugs.  The developer simply missing the warning amongst
> all the other crap.
> 
> It seems to especialy affect ia64 developers, whose build is especially
> noisy.

I know.  But that's the argument in favour of using diff, not shutting the
bogus warnings up...
