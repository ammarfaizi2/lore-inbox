Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbUCXOng (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 09:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263730AbUCXOnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 09:43:35 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:16849 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263729AbUCXOnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 09:43:31 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>, kgdb-bugreport@lists.sourceforge.net,
       Anurekh Saxena <anurekh.saxena@timesys.com>
Subject: Re: [Kgdb-bugreport] kgdb_arch_set/remove_break() ?
Date: Wed, 24 Mar 2004 20:05:21 +0530
User-Agent: KMail/1.5
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040319160359.GD4569@smtp.west.cox.net>
In-Reply-To: <20040319160359.GD4569@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403242005.21197.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 Mar 2004 9:33 pm, Tom Rini wrote:
> Hi.  Right now I'm writing up a porting doc that describes the various
> hook functions we've got.  I noticed that nothing is calling
> kgdb_arch_set/remove_break.  Is there some arch we're expecting will
> need this?  I'd like to just go ahead and remove them

I can't remember why that was done. A processor other than PPC, x86 and x86_64 
needs a special implementation of set and remove breakpoint, I guess.

Anurekh, who did initial implementation of arch independent-dependent split 
may have some comments on this.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

