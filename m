Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTFFSri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTFFSri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:47:38 -0400
Received: from 216-42-72-142.ppp.netsville.net ([216.42.72.142]:13985 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262177AbTFFSrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:47:37 -0400
Subject: Re: short freezing while file re-creation
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030606160217.GE6455@namesys.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	 <2804790000.1052441142@aslan.scsiguy.com>
	 <20030509120648.1e0af0c8.skraw@ithnet.com>
	 <20030509120659.GA15754@alpha.home.local>
	 <20030509150207.3ff9cd64.skraw@ithnet.com>
	 <20030606091759.GC23608@namesys.com>
	 <20030606172454.6f3cbeed.skraw@ithnet.com>
	 <20030606160217.GE6455@namesys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054926053.23132.278.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Jun 2003 15:00:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-06 at 12:02, Oleg Drokin wrote:
> Hello!
> 
> On Fri, Jun 06, 2003 at 05:24:54PM +0200, Stephan von Krawczynski wrote:
> 
> > while experimenting around my other problem I noticed my box freezes for some
> > seconds while tar is re-creating an archive of around 70 GB size on a reiserfs
> > with 3ware-connected device.
> > This is experienced with 2.4.21-rc7. Reproducable via:
> > create BIG tar archive file (my size 70 GB) on a reiserfs
> > re-create same archive and watch box gone dead while the old archive is zapped.
> > (Gone dead means: mouse froze, keyboard froze, X froze)
> 
> Hm, I will try .
> 
> Wild guess: does this patch helps? (untessted, not even compiled, but should be safe )
> 

There are still some latency issues with io in rc7, it could be a
general problem.

-chris


