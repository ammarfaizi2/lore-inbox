Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTJIBRO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 21:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTJIBRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 21:17:13 -0400
Received: from redgate.vislab.usyd.edu.au ([129.78.157.26]:60857 "EHLO
	redgate.vislab.usyd.edu.au") by vger.kernel.org with ESMTP
	id S261868AbTJIBRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 21:17:13 -0400
Subject: NFS client freezes in 2.6.0-test*, 2.4.21+
From: Steve Smith <ssmith@vislab.usyd.edu.au>
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Content-Type: text/plain
Message-Id: <1065662229.1024.6.camel@piccinini.vislab.usyd.edu.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 11:17:09 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing repeatable freezes in all the 2.6 test kernels and also in
2.4 kernels > 2.4.20.  It is reproducible simply by mounting an NFS
volume (hard or automount) and doing a 'find' on it.  The whole system
will then intermittently freeze for several seconds.

The server is a Slackware system kernel 2.4.21-xfs, export options are
(rw,no_root_squash,sync), the client is Debian unstable with any of the
above kernels.  The protocol version is v3.

Cheers,
Steve



