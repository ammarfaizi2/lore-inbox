Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUFXIj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUFXIj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 04:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUFXIj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 04:39:56 -0400
Received: from havoc.gtf.org ([216.162.42.101]:50655 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263802AbUFXIjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 04:39:55 -0400
Date: Thu, 24 Jun 2004 04:39:10 -0400
From: David Eger <eger@havoc.gtf.org>
To: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: i8042 driver non-determinantly chokes mac on boot
Message-ID: <20040624083910.GA14068@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Though I'm not sure I even have an i8042 (I'm guessing no, as I run
on a Mac) the detection failure path has gone a little wonky in recent
kernels.  Half the time it times out with the following (as it ought, 
me thinks)

IN from bad port 64 at c01f3100
IN from bad port 64 at c01f3100
IN from bad port 64 at c01f3100
IN from bad port 64 at c01f3100
i8042.c: i8042 controller self test timeout.

But the other half of the time it stalls my machine out entirely.
Clues?  Want my .config?

I'm running on a Titanium PowerBook3,5.

-dte
