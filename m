Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbTE2SEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 14:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTE2SEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 14:04:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30711 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S262473AbTE2SEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 14:04:23 -0400
Subject: Re: [announce] procps 2.0.13 with NPTL enhancements
From: Robert Love <rml@tech9.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Xose Vazquez Perez <xose@wanadoo.es>,
       linux-kernel <linux-kernel@vger.kernel.org>, miquels@cistron-office.nl
In-Reply-To: <20030529180830.GG5643@fs.tum.de>
References: <3ED6426F.6010807@wanadoo.es>  <20030529180830.GG5643@fs.tum.de>
Content-Type: text/plain
Message-Id: <1054206965.783.383.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 29 May 2003 11:16:06 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-29 at 18:08, Adrian Bunk wrote:

> Well, since I read Albert Cahalan's comment in Debian bug #172735 [1] 
> I understand the people maintaining a different branch...

Exactly.

That bug is fixed in the official tree, fyi. A segfault, as you said, is
always a bug. An error message is displayed.

Once that bug is fixed, he will probably find that the inability to read
files in /proc also causes a crash. Such is the problem with this
duplicated effort. It sucks. I told Albert I would be happy to merge
each and every (sane) change he sends me. He refuses. To be fair, I also
refuse to work under his tree. His comments on this list is part of the
reason. For what its worth, he did not fork off and create his tree
until Rik starting work on the official tree.

In the end, all that matters to me really is that Red Hat and other big
distributions use my tree (apparently whether I maintain it or not) and
I use those distributions. If I used Debian, maybe my view would be
different. Or maybe I would make them switch trees :)

	Robert Love

