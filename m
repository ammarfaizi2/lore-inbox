Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265456AbTFMRvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265457AbTFMRvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:51:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54777 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265456AbTFMRvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:51:43 -0400
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
From: Robert Love <rml@tech9.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20030613160335.GO828@ip68-0-152-218.tc.ph.cox.net>
References: <E19Qeoz-0004CM-00@calista.inka.de>
	 <3EE9DA08.2020707@nortelnetworks.com>
	 <20030613160335.GO828@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Message-Id: <1055527639.662.364.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 13 Jun 2003 11:07:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-13 at 09:03, Tom Rini wrote:

> ... only if we say a min gcc version of 3.3 however, yes?  Otherwise the
> kernel gets rather bloated.  Just how wide-spread (and Good To Use) is
> gcc-3.3 now?

Good point.

I have been using gcc-3.3 for awhile now with success, and I can
recommend it at least for x86, but that really is not reason to force
anyone to move to it (yet).

So this change will be nice when gcc 3.3 or greater is the minimum
compiler, but not very nice until then. If we start eradicating ifdefs
users of older compilers will get very bloated kernels.

I would also like it if we did not have to do the hackish inling
stuff...

	Robert Love

