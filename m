Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUFPHWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUFPHWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 03:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUFPHWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 03:22:20 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:5249 "EHLO crianza")
	by vger.kernel.org with ESMTP id S266199AbUFPHWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 03:22:19 -0400
Date: Wed, 16 Jun 2004 03:22:13 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tg3 wrong speed
Message-ID: <20040616072213.GG13868@porto.bmb.uga.edu>
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

I just booted 2.6.7, and eth1 came up in 100Mbit mode as happened with
-mm, and packet loss ensued.  I think maybe that the switch is only
allowing 1000Mbit operation.  I rebooted into single user mode to
restore the old kernel, but the second time eth1 came up at 1000Mbit so
the networking works now.  The serial console is no better than before,
but not completely broken like in -mm.

I'll leave 2.6.7 running today and see how it does.

-ryan
