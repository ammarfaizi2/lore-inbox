Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266114AbUFPEyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUFPEyf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 00:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUFPEye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 00:54:34 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:4737 "EHLO crianza")
	by vger.kernel.org with ESMTP id S266114AbUFPEyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 00:54:33 -0400
Date: Wed, 16 Jun 2004 00:53:30 -0400
From: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-ID: <20040616045330.GE13868@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615062236.GA12818@porto.bmb.uga.edu> <20040615030932.3ff1be80.akpm@osdl.org> <20040615150036.GB12818@porto.bmb.uga.edu> <20040615162607.5805a97e.akpm@osdl.org> <20040616024842.GC13672@porto.bmb.uga.edu> <20040615195822.7e7151aa.akpm@osdl.org> <20040616041313.GC13868@porto.bmb.uga.edu> <20040615212516.521bbb3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615212516.521bbb3f.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 09:25:16PM -0700, Andrew Morton wrote:
> So what do we conclude from this?  It booted OK, but the serial console
> broke, and perhaps the serial driver broke, and perhaps the tg3 driver
> broke?

I didn't notice this before, but with -mm eth1 came up in 100Mbit mode,
so I guess there is something wrong with tg3.  Since that seems to be
part of the problem, I won't try the experiment I just described unless
you think it would be useful.

-ryan
