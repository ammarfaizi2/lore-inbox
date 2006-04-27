Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWD0DAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWD0DAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 23:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWD0DAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 23:00:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:675 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964902AbWD0DAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 23:00:35 -0400
Subject: Re: Simple header cleanups
From: David Woodhouse <dwmw2@infradead.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1FYwE4-00047r-00@w-gerrit.beaverton.ibm.com>
References: <E1FYwE4-00047r-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 04:00:30 +0100
Message-Id: <1146106830.2885.44.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 19:27 -0700, Gerrit Huizenga wrote:
> Plus, do we really want Apache or other licensed software directly
> including GPL header files?  Oh what a tangled web we weave when we
> suck GPL headers into other applications. 

libstdc++ is GPL too. Why's that not a problem? Because it has an
exception explicitly allowing you to use it _without_ becoming covered
by the GPL, in certain circumstances. A bit like this one:

   NOTE! This copyright does *not* cover user programs that use kernel
 services by normal system calls - this is merely considered normal use
 of the kernel, and does *not* fall under the heading of "derived work".

Of course, the libstdc++ exception was written a bit more carefully than
ours, but ours seems to be perfectly sufficient.

http://gcc.gnu.org/onlinedocs/libstdc++/17_intro/license.html

-- 
dwmw2

