Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263216AbTDGDXp (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbTDGDXp (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:23:45 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:16900
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263216AbTDGDXo 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 23:23:44 -0400
Subject: Re: 2.5.66-bk12 causes "rpm" errors
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: rpjday@mindspring.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030406202926.762754ea.akpm@digeo.com>
References: <20030406183234.1e8abd7f.akpm@digeo.com>
	 <Pine.LNX.4.44.0304062200570.1604-100000@localhost.localdomain>
	 <20030406182815.65dd9304.akpm@digeo.com> <1049685316.894.5.camel@localhost>
	 <20030406202926.762754ea.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049686511.894.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 06 Apr 2003 23:35:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 23:29, Andrew Morton wrote:

> But that's a different error.  Robert (Day) reported:
> 
>  rpmdb: unable to join the environment
>  error: db4 error(11) from dbenv->open: Resource temporarily unavailable
>  error: cannot open Packages index using db3 - Resource temporarily unavailable (11)
>  error: cannot open Packages database in /var/lib/rpm
> 
> but then again, there's no way in which the patch which we're discussing
> could cause EAGAIN.

Oh, sorry for not mentioning. I see both... I think it depends whether a
previous error left a stale lock around.  Its the same problem, trust
me.

> Has anyone straced a failing rpm command?

I sent one out...

	Robert Love

