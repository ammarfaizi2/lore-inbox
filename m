Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUF0GdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUF0GdH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 02:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266277AbUF0GdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 02:33:07 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:57218 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266273AbUF0GdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 02:33:02 -0400
Date: Sat, 26 Jun 2004 23:32:53 -0700
From: Paul Jackson <pj@sgi.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, blaisorblade_spam@yahoo.it, linux-kernel@vger.kernel.org
Subject: Re: Inclusion of UML in 2.6.8
Message-Id: <20040626233253.06ed314e.pj@sgi.com>
In-Reply-To: <20040627035923.GB8842@ccure.user-mode-linux.org>
References: <200406261905.22710.blaisorblade_spam@yahoo.it>
	<20040626130945.190fb199.akpm@osdl.org>
	<20040627035923.GB8842@ccure.user-mode-linux.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm looking at quilt

Good tool.

It's a bit like a loaded gun with no safety. You will learn a few new
ways to shoot your foot off, and become good at first aid.  You will
want someway to keep personal revision history of your patches, to aid
in such repair work.  CVS or RCS or local bitkeeper or (for ancient
hackers like me) raw SCCS or some such.  Quilt handles the patches, but
in and of itself has nothing to do with preserving history.

All software is divided into two parts - the concrete and the fluid.

Once something is accepted into the main kernel, it's concrete.  You can
never go back - you can only layer fixes on top.  Bitkeeper rules for
this stuff.

But work in progress, for which oneself is still the primary source, is
fluid.  You can slice and dice and redo it, and indeed you want to, to
get the best patch set.  Quilt and friends rule for this stuff.

Conclusion - use Quilt (with your favorite personal version control) on
top of Bitkeeper.

Question - what tools are available for convenient patch set submission?
Composing multiple, related email sets in a GUI emailer is a bit tedious
and error prone.  It's an obvious candidate for scripting.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
