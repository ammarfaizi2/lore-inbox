Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTD1GCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 02:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263499AbTD1GCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 02:02:54 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:38288 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263462AbTD1GCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 02:02:53 -0400
Date: Mon, 28 Apr 2003 02:15:08 -0400
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Houston, I think we have a problem
Message-ID: <20030428061508.GC23469@delft.aura.cs.cmu.edu>
Mail-Followup-To: Mike Galbraith <efault@gmx.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com> <5.2.0.9.2.20030427090009.01f89870@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.0.9.2.20030427090009.01f89870@pop.gmx.net>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 12:52:49PM +0200, Mike Galbraith wrote:
> <SQUEAK!  SQUEAK!  SQUEAK!>
<description>

Hehe, at first I thought you were describing the excessive flamewars
where someone of 'low priority' downs a semaphore (flameworthy topic)
which then 'starves' useful discussions for several days. One good thing
is that is looks like fewer core developers seem to get sucked up in
these nowadays. (perhaps they have switched to some lockless RCU scheme?)

In any case, I have seen minute long stalls with 100% cpu usage about 3
or 4 times. I believe it started around the time the interactive
scheduler changes went in. One time it looked like the xserver, the
windowmanager and an inactive xterm were having a foodfight (when the
stall cleared a top showed 50%/25%/25% cpu usage for those processes).

Interestingly this was right after a reboot, so most of the 1GB of
memory was not used.

Jan
