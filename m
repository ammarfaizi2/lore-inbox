Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWDFU0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWDFU0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 16:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWDFU0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 16:26:07 -0400
Received: from xenotime.net ([66.160.160.81]:4574 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751235AbWDFU0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 16:26:06 -0400
Date: Thu, 6 Apr 2006 13:28:23 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: agruen@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modules_install must not remove existing modules
Message-Id: <20060406132823.5c830ec6.rdunlap@xenotime.net>
In-Reply-To: <20060406064310.GA24785@mars.ravnborg.org>
References: <200604052333.51085.agruen@suse.de>
	<20060406064310.GA24785@mars.ravnborg.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2006 08:43:10 +0200 Sam Ravnborg wrote:

> On Wed, Apr 05, 2006 at 11:33:50PM +0200, Andreas Gruenbacher wrote:
> > When installing external modules with `make modules_install', the
> > first thing that happens is a rm -rf of the target directory. This
> > works only once, and breaks when installing more than one (set of)
> > external module(s). Bug introduced in:
> >   http://www.kernel.org/hg/linux-2.6/?cs=bbb3915836f5
> > 
> > Sam, is this fix okay with you?
> Applied.
> We should document this somewhere...

Sam, did you apply the original patch from Andreas or some updated one?

---
~Randy
