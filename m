Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270466AbUJUBmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270466AbUJUBmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270574AbUJUBl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:41:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:58790 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270453AbUJUBia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:38:30 -0400
Subject: Re: Versioning of tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Len Brown <len.brown@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org>
References: <1098254970.3223.6.camel@gaston>
	 <1098256951.26595.4296.camel@d845pe>
	 <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1098322686.21028.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 11:38:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 00:33, Linus Torvalds wrote:

> Personally, I much rather go the way we have gone, because I don't care
> about module versioning nearly as much as I care about bug-report
> versioning. And if I hear about a bug with 2.6.10-rc1, I want to know that
> it really is at _least_ 2.6.10-rc1, if you see what I mean..

I have the same problem with reports. I'm not talking about -rc*, that
is fine, I know that a report against rc-* means and most user will usually
tell me rc*-bk* so that's ok.

The problem is just with this intermediate state between 2.6.N "final" and
whatever gets next until we go to -rc. The fact that it has the exact same
version as 2.6.N final means that I get confusing reports (and, but I know
you don't care about modules, but it's simply impossible to have both
the "final" modules and the "current top of tree" modules installed at the
same time, which _is_ painful).

When I was still doing my "pmac" tree, what I would do was to put -pre0
in the EXTRAVERSION after a release until I got to -preX or -rcX...

Anyway, it's your call.

Ben.

