Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267343AbUH2IJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUH2IJP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 04:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267351AbUH2IJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 04:09:14 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:51030 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267343AbUH2IJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 04:09:12 -0400
Date: Sun, 29 Aug 2004 10:10:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, jdubois@mc.com
Subject: Re: [patch 1/3]
Message-ID: <20040829081038.GE7325@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org, jdubois@mc.com
References: <200408272153.OAA28839@av.mvista.com> <20040827220057.GA30360@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827220057.GA30360@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 03:00:57PM -0700, Tom Rini wrote:
> On Fri, Aug 27, 2004 at 02:53:04PM -0700, trini@kernel.crashing.org wrote:
> 
> > #   The following is from Jean-Christophe Dubois <jdubois@mc.com>.
> > #   On Solaris 2.8, <stdint.h> does not exist, but <inttypes.h> does.
> > #   However, on cygwin (the other odd place that the kernel is compiled
> > #   on) <inttypes.h> doesn't exist.  So we end up with something like
> > #   the following.
> > #   
> > #   Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> Arg, I thought I refpatch'ed, but didn't, so they all came out just a
> bit wrong.  The descs elsewhere were correct, but this should have been:
> On Solaris 2.8, <stdint.h> does not exist, but <inttypes.h> does.
> However, on Cygwin (the other odd place that the kernel is compiled
> on) <inttypes.h> doesn't exist.  So we end up testing for __sun__ and
> using <inttypes.h> there, and <stdint.h> everywhere else.

All three patches applied - thanks!

	Sam
