Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVIKWxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVIKWxA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVIKWxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:53:00 -0400
Received: from xenotime.net ([66.160.160.81]:52142 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751000AbVIKWw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:52:59 -0400
Date: Sun, 11 Sep 2005 15:52:56 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] make add_taint() inline
Message-Id: <20050911155256.48bf15cb.rdunlap@xenotime.net>
In-Reply-To: <20050911124434.1967ac6e.akpm@osdl.org>
References: <20050911103757.7cc1f50f.rdunlap@xenotime.net>
	<20050911104437.6445ff20.donate@madrone.org>
	<20050911124434.1967ac6e.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2005 12:44:34 -0700 Andrew Morton wrote:

> donate <donate@madrone.org> wrote:
> >
> > From: donate <donate@madrone.org>
> 
> Who is this?

Just some little mistake that I have since corrected.
Sorry about that.

> > From: Randy Dunlap <rdunlap@xenotime.net>
> 
> >  add_taint() is a trivial function.
> >  No need to call it out-of-line, just make it inline and
> >  remove its export.
> 
> Well, presumably add_taint() was exported to modules for a reason.  If that
> reason was valid then this patch requires that `tainted' be exported to
> modules too.  And that allows naughty modules to trivially zero it out.

Got it, thanks.  That's why it said [RFC].

---
~Randy
