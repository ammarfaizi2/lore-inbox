Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUH1KZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUH1KZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUH1KWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:22:36 -0400
Received: from smtp3.libero.it ([193.70.192.127]:40885 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S267411AbUH1KTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 06:19:50 -0400
From: Giacomo Lozito <city_hunter@azzurra.org>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cdrecord as normal user broken with kernel 2.6.8.1
Date: Sat, 28 Aug 2004 12:22:13 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408281222.14293.city_hunter@azzurra.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's crystal clear that applications should run correctly with a kernel,
and it is not the kernel that should be made to work with them.
By the way, things are already getting fixed in next kernel releases.

Nevertheless, a problem exists.
I wouldn't expect relevant things (such as CD burning) to broke within stable 
series of a kernel. It's ok if things break with 2.5 or 2.7, but should it be 
the same for 2.6?

In my humble opinion, a nice and good way to tighten security for some 
commands was to give it as an option in ATA/ATAPI/MFM/RLL or SCSI section in 
kernel configuration.
That way people could read "this option improves security, it will become 
standard in later kernels, but be aware that it could make cdrecording tools 
not functional when they are run from a normal user account"
and people could decide what to do.

Wasn't that more reasonable?

Regards,
Giacomo Lozito
