Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272305AbTGYUdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272306AbTGYUdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:33:14 -0400
Received: from devil.servak.biz ([209.124.81.2]:55986 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S272305AbTGYUdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:33:12 -0400
Subject: Re: Firewire
From: Torrey Hoffman <thoffman@arnor.net>
To: Chris Ruvolo <chris+lkml@ruvolo.net>
Cc: Ben Collins <bcollins@debian.org>, gaxt <gaxt@rogers.com>,
       Sam Bromley <sbromley@cogeco.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <20030725193515.GQ23196@ruvolo.net>
References: <20030725142926.GD1512@phunnypharm.org>
	 <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net>
	 <20030725161803.GJ1512@phunnypharm.org>
	 <1059155483.2525.16.camel@torrey.et.myrio.com>
	 <20030725181303.GO23196@ruvolo.net> <20030725181252.GA607@phunnypharm.org>
	 <3F217A39.2020803@rogers.com> <20030725182642.GD607@phunnypharm.org>
	 <20030725184506.GE607@phunnypharm.org>  <20030725193515.GQ23196@ruvolo.net>
Content-Type: text/plain
Organization: 
Message-Id: <1059166095.1465.3.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Jul 2003 13:48:16 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-25 at 12:35, Chris Ruvolo wrote:
> On Fri, Jul 25, 2003 at 02:45:06PM -0400, Ben Collins wrote:
> > Maybe it wont. Try reverting back to stock, and apply this patch. I am
> > pretty sure this will fix the problem for anyone having this issue.
> 
> Yes, I think this did it!  One change: needed to change HSBP_VERBOSE to
> HSBP_DEBUG in csr.c.  
> 

It works for me too... so far at least.  I've attached and mounted my
external CDRW and 250 GB hard drives and have no errors in the system
logs...  everything seems to work at first glance.  I will do a little
stress testing after lunch and let you know how it goes.

Thanks!

-- 
Torrey Hoffman <thoffman@arnor.net>

