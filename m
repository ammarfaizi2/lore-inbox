Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVCKU4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVCKU4U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVCKUzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:55:20 -0500
Received: from mail.tmr.com ([216.238.38.203]:58372 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261529AbVCKUxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:53:54 -0500
Date: Fri, 11 Mar 2005 15:42:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Chris Friesen <cfriesen@nortel.com>
cc: "Justin M. Forbes" <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.Stable and EXTRAVERSION
In-Reply-To: <423202D2.8000207@nortel.com>
Message-ID: <Pine.LNX.3.96.1050311154019.20262B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, Chris Friesen wrote:

> Bill Davidsen wrote:

	[...snip...]

> > I think it will confuse scripts which expect something local in the 4th 
> > field. I confess that I have such, and that field is turned into a 
> > directory name during builds, so test results are saved in a proper 
> > place. I think vendors and people who care will just keep three digits, 
> > and those who want the last can make their EXTRAVERSION
> >    2.Joes_Bar_&_Grill_486
> > or whatever is needed.
> 
> There's also the LOCALVERSION that can be set in the config file.  I've 
> switched to using that, since it means one less kernel patch to port.

I have to see what that generates. The problem is LOCALVERSION and current
use of both 3 and 4 field kernel versions. You need a smarter script to
handle that.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

