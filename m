Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbTDGDbs (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbTDGDbs (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:31:48 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:40964
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263230AbTDGDbq 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 23:31:46 -0400
Subject: Re: Wanted: a limit on kernel log buffer size
From: Robert Love <rml@tech9.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org
In-Reply-To: <33271.4.64.238.61.1049686559.squirrel@webmail.osdl.org>
References: <200304062137_MC3-1-3346-A97E@compuserve.com>
	 <33182.4.64.238.61.1049683748.squirrel@webmail.osdl.org>
	 <33271.4.64.238.61.1049686559.squirrel@webmail.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049686794.894.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 06 Apr 2003 23:39:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 23:35, Randy.Dunlap wrote:

> > a.  If someone won't read the help text, how can we help them?
> >
> > b.  If we make a 2 GB log buffer size a compile-time error, will
> > they read that?
> >
> > c.  If we make it a compile-time warning, will they read that?
> >
> > d.  What limit(s) do you suggest?  I can try to add some limits.
> >
> > e.  This kind of config limiting should be done in the config system IMO.
> > I've asked Roman for that capability....
> 
> Here's a patch that limits kernel log buffer size to 1 MB max.
> Comments?

I liked points (a) and (e) above.

I say if users cannot bother to read the documentation and understanding
things, why are they compiling a kernel?

And if we are going to implement parameters bounds checking it should be
done in kconfig.  There are a few other places that want it, too.

	Robert Love

