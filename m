Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbTFMPuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265419AbTFMPuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:50:00 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:7571 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S265418AbTFMPt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:49:59 -0400
Date: Fri, 13 Jun 2003 09:03:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
Message-ID: <20030613160335.GO828@ip68-0-152-218.tc.ph.cox.net>
References: <E19Qeoz-0004CM-00@calista.inka.de> <3EE9DA08.2020707@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE9DA08.2020707@nortelnetworks.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 10:04:56AM -0400, Chris Friesen wrote:

> Bernd Eckenfels wrote:
> 
> >does that mean the current linux source tree does not benefit in any way
> >from this patch?
> 
> I suspect that currently all such instances are wrapped in #ifdef and are 
> not currently compiled in. As he said in the original message,  "it'd be 
> nice to discard unused functions (think CONFIG_PROC_FS=n) without needing 
> to #ifdef around them."
> 
> This would allow us to remove those #ifdefs.

... only if we say a min gcc version of 3.3 however, yes?  Otherwise the
kernel gets rather bloated.  Just how wide-spread (and Good To Use) is
gcc-3.3 now?

-- 
Tom Rini
http://gate.crashing.org/~trini/
