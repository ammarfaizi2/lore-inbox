Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263116AbUJ2Gpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbUJ2Gpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 02:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUJ2Gpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 02:45:33 -0400
Received: from almesberger.net ([63.105.73.238]:38151 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263116AbUJ2Gp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 02:45:27 -0400
Date: Fri, 29 Oct 2004 03:44:44 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Chris Wedgwood <cw@f00f.org>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Why UML often does not build (was: Re: [PATCH] UML: Build fix for TT w/o SKAS)
Message-ID: <20041029034444.A24523@almesberger.net>
References: <20041027053602.GB30735@taniwha.stupidest.org> <200410282254.21944.blaisorblade_spam@yahoo.it> <20041028214242.GB2269@taniwha.stupidest.org> <200410290149.31665.blaisorblade_spam@yahoo.it> <20041029002831.GD12434@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029002831.GD12434@taniwha.stupidest.org>; from cw@f00f.org on Thu, Oct 28, 2004 at 05:28:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> the problem here is that ptrace semantics are not well defined to
> anything subtle can and will break from time to time

I wonder what the "correct" solution for this would be: write a
specification for Linux ptrace, or try to get the POSIX folks
interested ?

Given that we get subtle ptrace breakages quite regularly, it
would be nice to see this eventually get resolved. "The
implementation is the specification" doesn't seem to work well
in this case.

BTW, things have improved around UML quite a bit recently, and I
think this is to no small amount due to Paolo's work.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
