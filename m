Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbUKEP3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbUKEP3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 10:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbUKEP2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 10:28:47 -0500
Received: from [213.146.154.40] ([213.146.154.40]:7058 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261635AbUKEP1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 10:27:54 -0500
Subject: RE: Possible GPL infringement in Broadcom-based routers
From: David Woodhouse <dwmw2@infradead.org>
To: davids@webmaster.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKCENFPIAA.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKCENFPIAA.davids@webmaster.com>
Content-Type: text/plain
Message-Id: <1099668469.4542.36.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 05 Nov 2004 15:27:49 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 15:57 -0800, David Schwartz wrote:
> > Can Broadcom and the vendors "escape" the obligations of the GPL by
> > shipping those proprietary drivers as modules, or are they violating the
> > GPL plain and simple by removing the related source code (and showing
> > irrelevant code to show "proof of good will") ?
> 
> 	That is a contentious issue that has been debated on this group far too
> much. In the United States, at least, the answer comes down to the complex
> legal question of whether the module is a "derived work" of the Linux kernel
> and whether the kernel as shipped with those modules is a "mere
> aggregation".

Not quite.

It comes down to a question of whether their firmware as a whole is a
'collective work' based in part on the Linux kernel, or whether the
whole thing can be considered 'mere aggregation' despite the fundamental
interdependency between the kernel and their drivers, without either of
which the entire device would be useless.

	"These requirements apply to the modified work as a whole.  If
	identifiable sections of that work are not derived from the
	Program, and can be reasonably considered independent and
	separate works in themselves, then this License, and its terms,
	do not apply to those sections when you distribute them as
	separate works."

This is the bit you seem to be thinking of -- when it's not actually a
derived work. But the GPL goes on and explicitly talks about your
obligations with respect even to non-derived works, if distributed as
part of a larger whole:

		        "But when you distribute the same sections as
	part of a whole which is a work based on the Program, the
	distribution of the whole must be on the terms of this License,
	whose permissions for other licensees extend to the entire
	whole, and thus to each and every part regardless of who wrote
	it.
                                                                                	"Thus, it is not the intent of this section to claim rights or
	contest your rights to work written entirely by you; rather, the
	intent is to exercise the right to control the distribution of
	derivative or collective works based on the Program."


-- 
dwmw2

