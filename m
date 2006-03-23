Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWCWWtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWCWWtC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWCWWtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:49:02 -0500
Received: from rtr.ca ([64.26.128.89]:9674 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932545AbWCWWtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:49:00 -0500
Message-ID: <442325DA.80300@rtr.ca>
Date: Thu, 23 Mar 2006 17:48:58 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] swsusp: separate swap-writing/reading code
References: <200603231702.k2NH2OSC006774@hera.kernel.org> <200603240713.41566.ncunningham@cyclades.com> <200603232253.01025.rjw@sisk.pl>
In-Reply-To: <200603232253.01025.rjw@sisk.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
>
> I agree it probably may be improved.  Still it seems to be good enough.  Further,
> it's more efficient than the previous solution, so I consider it as an improvement.
> Also this code has been tested for quite some time in -mm and appears to
> behave properly, at least we haven't got any bug reports related to it so far.

I find the in-kernel swsusp to be quite slow, and it seems to use
an awful lot of memory for book-keeping.  So count that as encouragement
to improve the performance when you can.

> Currently I'm not working on any better solution.  If you can provide any
> patches to implement one, please submit them, but I think they'll have to be
> tested for as long as this code, in -mm.

It would be *really nice* if you guys could stop being so underhandedly
nasty in every single reply to anything from Nigel.

He really is trying to help, you know.

Cheers
