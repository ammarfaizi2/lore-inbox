Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTK0Kgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 05:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTK0Kgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 05:36:47 -0500
Received: from gate.in-addr.de ([212.8.193.158]:51105 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S264472AbTK0Kgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 05:36:45 -0500
Date: Thu, 27 Nov 2003 11:36:43 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: md/raid devices don't show up in /proc/partitions in 2.6 :-(
Message-ID: <20031127103643.GB4954@marowsky-bree.de>
References: <16325.16910.697589.124844@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16325.16910.697589.124844@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-11-27T11:15:10,
   Neil Brown <neilb@cse.unsw.edu.au> said:

> I just noticed that md devices do not show up in /proc/partitions in
> 2.6.

Using /proc/partitions for finding the existing block devices /
partitions does seem to be kind of obsolete, as sysfs exports all of
this information too?

So, if anything, I'd drop the confusing redundancy and kill
/proc/partitions - the names there may have little resemblance to how
udev (et al) chose to name the device node in the filesystem anyway.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

