Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268497AbUHYHXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268497AbUHYHXx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268505AbUHYHXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:23:52 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:63640 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S268497AbUHYHXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:23:50 -0400
Date: Wed, 25 Aug 2004 03:23:43 -0400
To: mcetra@navynet.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: Production comparison between 2.4.27 and 2.6.8.1
Message-ID: <20040825072343.GA288@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What can I try to improve performance ?

In benchmarks I've done, XFS was helped significantly
by the mkfs/mount options in the XFS FAQ.  (look
for the dbench question).

http://oss.sgi.com/projects/xfs/faq.html

mkfs -t xfs -l size=32768b -f /dev/device
mount -t xfs -o logbufs=8,logbsize=32768 /dev/device /mountpoint

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

