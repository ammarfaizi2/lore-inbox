Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWFKOel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWFKOel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 10:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWFKOel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 10:34:41 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:54685 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751596AbWFKOel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 10:34:41 -0400
Date: Sun, 11 Jun 2006 16:34:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] header install: cosmetic cleanups to kbuild infrastructure
Message-ID: <20060611143427.GA21490@mars.ravnborg.org>
References: <20060611121005.GA1342@mars.ravnborg.org> <1150030039.5213.254.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150030039.5213.254.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2006 at 01:47:19PM +0100, David Woodhouse wrote:
> On Sun, 2006-06-11 at 14:10 +0200, Sam Ravnborg wrote:
> > -headers_install: include/linux/version.h
> > +headers_install: prepare 
> 
> That breaks cross-export of headers when we don't have a cross-compiler.

That was i thinko that slept through. In general avoiding all the
specific dependencies in the mess that is named Makefile is good but
in this case there is no good reason to use the prepare targets.

	Sam
