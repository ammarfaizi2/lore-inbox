Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWDFU3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWDFU3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 16:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWDFU3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 16:29:12 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:44298 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751235AbWDFU3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 16:29:11 -0400
Date: Thu, 6 Apr 2006 22:29:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: agruen@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modules_install must not remove existing modules
Message-ID: <20060406202905.GA10219@mars.ravnborg.org>
References: <200604052333.51085.agruen@suse.de> <20060406064310.GA24785@mars.ravnborg.org> <20060406132823.5c830ec6.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406132823.5c830ec6.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 01:28:23PM -0700, Randy.Dunlap wrote:
> On Thu, 6 Apr 2006 08:43:10 +0200 Sam Ravnborg wrote:
> 
> > On Wed, Apr 05, 2006 at 11:33:50PM +0200, Andreas Gruenbacher wrote:
> > > When installing external modules with `make modules_install', the
> > > first thing that happens is a rm -rf of the target directory. This
> > > works only once, and breaks when installing more than one (set of)
> > > external module(s). Bug introduced in:
> > >   http://www.kernel.org/hg/linux-2.6/?cs=bbb3915836f5
> > > 
> > > Sam, is this fix okay with you?
> > Applied.
> > We should document this somewhere...
> 
> Sam, did you apply the original patch from Andreas or some updated one?
The original patch from Andreas.

It is not yet pushed - I need to sort out a few klibc related bits
first.

	Sam
