Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266120AbUFPEly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266120AbUFPEly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 00:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUFPEly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 00:41:54 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:4225 "EHLO crianza")
	by vger.kernel.org with ESMTP id S266120AbUFPElx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 00:41:53 -0400
Date: Wed, 16 Jun 2004 00:41:46 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-ID: <20040616044146.GD13868@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615062236.GA12818@porto.bmb.uga.edu> <20040615030932.3ff1be80.akpm@osdl.org> <20040615150036.GB12818@porto.bmb.uga.edu> <20040615162607.5805a97e.akpm@osdl.org> <20040616024842.GC13672@porto.bmb.uga.edu> <20040615195822.7e7151aa.akpm@osdl.org> <20040616041313.GC13868@porto.bmb.uga.edu> <20040615212516.521bbb3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615212516.521bbb3f.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 09:25:16PM -0700, Andrew Morton wrote:
> So what do we conclude from this?  It booted OK, but the serial console
> broke, and perhaps the serial driver broke, and perhaps the tg3 driver
> broke?

Something like that...  The serial console was certainly broken.  I'm
not so sure about the ethernet.  If you see my other messages about the
serial console, the boot process always hangs right after the ethernet
comes up, and I have to hold down a key on the serial console for a few
seconds to get it going again.  Maybe coincidence, maybe not.  Also it
could be the bonding driver rather than tg3.  Let me reboot the mainline
kernel again and I'll see if I get the same packet loss if I leave it
hung for a while.

-ryan
