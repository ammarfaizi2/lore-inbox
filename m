Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWDBTA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWDBTA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 15:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWDBTA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 15:00:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:8602 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750941AbWDBTAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 15:00:55 -0400
Subject: Re: Firewire problems, apparently since 2.6.13-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: gene.heskett@verizononline.net
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200604021418.16263.gene.heskett@verizon.net>
References: <200604021418.16263.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Sun, 02 Apr 2006 15:00:49 -0400
Message-Id: <1144004450.11043.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-02 at 13:18 -0500, Gene Heskett wrote:
> Greetings;
> 
> How much trouble will I have if I take the current 2.6.16.1 kernel src 
> tree, nuke the ieee1394 directory of it, and bring the ieee1394 
> directory in from the 2.6.12 tarball?
> 

This has no chance of working.

> At 2.6.12, all the firewire stuff I needed to import from my camera, 
> edit it, and make vcd's or dvd's out of it worked _flawlessly_.  Now, 
> at 2.6.16.1, and apparently since 2.6.13-rc1, kino is broken and must 
> be killed by the system when it hangs.  I figured it would get sorted, 
> but apparently not.
> 

That's always a bad assumption.  Bugs should be reported early and
often.

> I can recover from backups all the stuff I've overwritten in the last 2 
> days trying to make it work.  That should make it all work again IF the 
> ieee1394 stuff was reverted to the 2.6.12 version.  Is this feasable at 
> all?
> 

No - it would be a much better use of your time to put together an
actionable bug report.  The above is too vague... can you get an strace
or GDB backtrace of the hung process, dmesg, etc

Lee

