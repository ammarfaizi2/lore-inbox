Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVGVUfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVGVUfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVGVUfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:35:38 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:64699 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262158AbVGVUfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:35:36 -0400
Date: Fri, 22 Jul 2005 22:33:21 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Paul Jackson <pj@sgi.com>
Cc: rostedt@goodmis.org, relayfs-devel@lists.sourceforge.net,
       richardj_moore@uk.ibm.com, varap@us.ibm.com, karim@opersys.com,
       linux-kernel@vger.kernel.org, zanussi@us.ibm.com
Subject: relayfs as infrastructure,  ltt, systemtap, diskstat
Message-ID: <20050722203321.GD13270@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Paul Jackson <pj@sgi.com>, rostedt@goodmis.org,
	relayfs-devel@lists.sourceforge.net, richardj_moore@uk.ibm.com,
	varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
	zanussi@us.ibm.com
References: <17107.6290.734560.231978@tut.ibm.com> <20050716210759.GA1850@outpost.ds9a.nl> <17113.38067.551471.862551@tut.ibm.com> <20050717090137.GB5161@outpost.ds9a.nl> <17114.31916.451621.501383@tut.ibm.com> <20050717194558.GC27353@outpost.ds9a.nl> <1121693274.12862.15.camel@localhost.localdomain> <20050720142732.761354de.pj@sgi.com> <20050720214519.GA13155@outpost.ds9a.nl> <20050722130132.60f1524e.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722130132.60f1524e.pj@sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 01:01:32PM -0700, Paul Jackson wrote:
> Another vote in favor of relayfs here ...

At OLS the 'SystemTAP' idea was presented, which has been partially
implemented already, and it builds on relayfs as well. It dovetails nicely
with kprobes.

So it appears there is a sizeable amount of code which is building on
relayfs, iow, it is getting to be infrastructure.

I'm redoing diskstat to work with k/jprobes so it won't require a kernel
patch anymore, but it will still rely on relayfs.

So it would be tremendously helpful if relayfs would be part of the
mainline. I'll be banging out some HOWTO style documentation soonish.

Bert.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
