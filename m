Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTFSNOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 09:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265538AbTFSNOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 09:14:30 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:41416 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265531AbTFSNOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 09:14:30 -0400
Date: Thu, 19 Jun 2003 15:28:10 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
Message-ID: <20030619132810.GA6906@wohnheim.fh-wedel.de>
References: <E19Qeoz-0004CM-00@calista.inka.de> <3EE9DA08.2020707@nortelnetworks.com> <20030613160335.GO828@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030613160335.GO828@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 June 2003 09:03:35 -0700, Tom Rini wrote:
> 
> ... only if we say a min gcc version of 3.3 however, yes?  Otherwise the
> kernel gets rather bloated.  Just how wide-spread (and Good To Use) is
> gcc-3.3 now?

I haven't seen a clear compiler bug yet, but found two bugs in
assembler code with 2.95.3 that compiled without problems with 3.2.x.
One of them has actually hit people, as you could see in the code.
Most symptoms were "fixed", but the cause remained.

If nothing else, I'd like to keep 2.95 as a code checker for at least
a year or two.  Give 3.x some more time to mature.

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike
