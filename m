Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTDROYX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 10:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTDROYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 10:24:23 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36364 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263053AbTDROYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 10:24:12 -0400
Date: Fri, 18 Apr 2003 10:31:00 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: John Jasen <jjasen@realityfailure.org>
cc: John Bradford <john@grabjohn.com>, jlnance@unity.ncsu.edu,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: RedHat 9 and 2.5.x support
In-Reply-To: <Pine.LNX.4.44.0304171054000.13853-100000@bushido>
Message-ID: <Pine.LNX.3.96.1030418102439.9185A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003, John Jasen wrote:

> On Thu, 17 Apr 2003, John Bradford wrote:
> 
> > If you don't use modules at all, and simply compile everything in, you
> > can ignore the modutils issue completely.  Other than that, you should
> > have no problems.
> 
> Isn't modules-init backward compatible, or did I read wrong somewhere?

It can be installed such that it calls the old versions, renamed to
xxx-old, if used from a 2.4 system. However, I don't think Redhat did that
type install for 9.0, so it will probably not work after an upgrade.

The last I looked modprobe.conf was a seriously deficient subset of
modules.conf, but I haven't d/l the latest version, so some of the
omissions may have been addressed. The major feature missing is (or was)
the lack of probe capability (and probeall). You can run a dual system,
but you do have to work at it a little bit.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

