Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbTIZUxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 16:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTIZUxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 16:53:34 -0400
Received: from h-64-236-243-31.twi.com ([64.236.243.31]:42083 "EHLO
	wbsmtphost.wb-mail.com") by vger.kernel.org with ESMTP
	id S261559AbTIZUxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 16:53:33 -0400
Subject: Prefered method to map PCI memory into userspace.
From: Jim Deas <jdeas@jadsystems.com>
Reply-To: jdeas@jadsystems.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: JAD Systems
Message-Id: <1064609623.16160.11.camel@ArchiveLinux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 26 Sep 2003 13:53:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking for the most current (blessed) structure
for mapping PCI memory to a user process. One that allows
both PIO and busmastering to work on a common block of
PCI RAM. I am not concerned with backporting to older
kernels but it would be nice if the solution wasn't ibm specific.

My problem is a 64M window into a frame buffer that I would
like to map into user space. I am more than willing to put
forth the effort, I just want to make sure I'm heading in
the right direction.

Is there a better forum for posting this? Regards,
J. Deas

RH9.0 2.4.20-6smp kernel and above.


-- 
Jim Deas <jdeas@jadsystems.com>
JAD Systems

