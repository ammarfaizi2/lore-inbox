Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbVJXOEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVJXOEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 10:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbVJXOEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 10:04:04 -0400
Received: from mxsf02.cluster1.charter.net ([209.225.28.202]:46976 "EHLO
	mxsf02.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751039AbVJXOED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 10:04:03 -0400
X-IronPort-AV: i="3.97,245,1125892800"; 
   d="scan'208"; a="1558580120:sNHT22085096"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17244.59851.9303.25151@smtp.charter.net>
Date: Mon, 24 Oct 2005 10:03:55 -0400
From: "John Stoffel" <john@stoffel.org>
To: Michael Brade <brade@informatik.uni-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ieee1394: sbp2: sbp2util_node_write_no_wait failed
In-Reply-To: <200510241451.27320.brade@informatik.uni-muenchen.de>
References: <200510241451.27320.brade@informatik.uni-muenchen.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael> I get the above message frequently while copying data (around
Michael> 200000 mail files, 2GB) from my laptop to an external
Michael> harddisk via ieee1394. The ieee system completely deadlocked
Michael> with 2.6.13 without the chance to umount or reuse the
Michael> device. Now I upgraded to 2.6.14-rc5 and I still get the
Michael> error followed by a 10sec pause or so, but then the copying
Michael> continues. I will have to check if it copied all data
Michael> correctly, though.

One thing I suggest right off the bat is to make sure that firmware on
your external enclosure is updated to the latest/greatest.  Alot of
vendors (esp those using the Prolific chipset) don't get it right
initially.  

Other than that, at least it's recovering better now and not locking
up!

John
