Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTDIMrf (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 08:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTDIMrf (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 08:47:35 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:34576 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S263299AbTDIMre (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 08:47:34 -0400
Subject: [ANNOUNCE]OpenSSI 0.9.6 is now available
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Digital India
Message-Id: <1049893911.24945.44.camel@satan.xko.dec.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 09 Apr 2003 18:41:51 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This was announced in ssi mailing list. 

-aneesh 

List:     ssic-linux-devel
Subject:  [SSI-devel] OpenSSI 0.9.6 is now available
From:     "Brian J. Watson" <Brian.J.Watson () hp ! com>
Date:     2003-04-04 23:19:33
[Download message RAW]

Since 0.8.0, OpenSSI has been booted on more than 67 IA-32 nodes.
It includes a first cut of HA-CFS, which allows the cluster to lose
its CFS root filesystem server node and continue running, if another
node is attached to the same disk. The Lustre and NFS clients were
integrated (non-root). LVS now automatically registers any socket
that does a listen(). Unix domain sockets, SysV shared memory, and
SysV semaphores are all clusterwide.

A /proc interface can now be used to migrate a process, rather than
SIGMIGRATE. An ssidevfs mount is now done for every node, and /dev
is a context symlink into the ssidevfs for a process' node. CFS now
supports file locking via fcntl(). The SSI version of util-linux has
been merged with 2.11z. The xinetd server is now run on all nodes by
default.

Various bugs have been fixed, including races, hangs, panics, and
problems with strace on IA64 and Alpha.

The latest version of OpenSSI is 0.9.6. Both binary RPMs and source
code can be found on http://openssi.org/.

Enjoy,

Brian

