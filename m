Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVBDJkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVBDJkq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 04:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVBDJkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 04:40:46 -0500
Received: from canuck.infradead.org ([205.233.218.70]:34829 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S263074AbVBDJkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 04:40:25 -0500
Subject: Re: Please open sysfs symbols to proprietary modules
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, mochel@digitalimplant.org
In-Reply-To: <20050204012042.6aedcf39.akpm@osdl.org>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
	 <20050204012042.6aedcf39.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 10:40:11 +0100
Message-Id: <1107510011.4263.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 01:20 -0800, Andrew Morton wrote:
> Pavel Roskin <proski@gnu.org> wrote:
> >
> > I'm writing a module under a proprietary license.
> 
> You shouldn't, although many people do.  It's a derived work and hence the
> GPL is applicable.  The only exception we make is for code which was
> written for other operating systems and was then ported to Linux.  Because
> it is inappropriate to consider such code a derived work.

Note that I would like to qualify the "we" word here for people who read
this later. It is apparently your (and based on earlier mails, Linus' as
well) opinion that you make an exception. Not all other kernel authors
have to, or do, feel the same way, especially in the light of a huge
gray area what "ported" means, eg there is a gray area about how much
new linux specific code is added. Say you port a driver from windows to
linux, and after the port 990 lines are linux specific and only 10 lines
are left from the old code...



