Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266202AbUGARre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUGARre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 13:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUGARre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 13:47:34 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:15760 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S266202AbUGARrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 13:47:32 -0400
Date: Thu, 1 Jul 2004 10:47:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: binutils woes
Message-ID: <20040701174731.GD15960@smtp.west.cox.net>
References: <20040701175231.B8389@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701175231.B8389@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 05:52:31PM +0100, Russell King wrote:

> Hi guys,
> 
> On ARM, we appear to have somewhat of a problem with binutils.  At
> least the following binutils suffer from a problem whereby it is
> possible to create programs which contain undefined symbols:
[snip]
> I think the only way we can ensure kernel correctness is to add a
> subsequent stage to kbuild such that whenever we generate a final
> program, we grep the 'nm' output for undefined symbols.
> 
> Comments?

Is there a version of binutils that really does get things right?  If
so, can't you Just Say No to older versions and force people to upgrade
(with a simple testcase done upfront) ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
