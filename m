Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTJFDmo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 23:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263970AbTJFDmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 23:42:44 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:38055 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S263969AbTJFDmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 23:42:43 -0400
From: Clemens Schwaighofer <schwaigl@eunet.at>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: linux 2.6 csv from 20031006
Date: Mon, 6 Oct 2003 12:42:17 +0900
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310061242.17809.schwaigl@eunet.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

after a clean checkout and just an load of the old config file, I get this 
during the compile

net/appletalk/aarp.c: In function `aarp_seq_start':
net/appletalk/aarp.c:944: parse error before '<<' token
net/appletalk/aarp.c:954: redeclaration of `iter'
net/appletalk/aarp.c:938: `iter' previously declared here
net/appletalk/aarp.c:959: `v' undeclared (first use in this function)
net/appletalk/aarp.c:959: (Each undeclared identifier is reported only once
net/appletalk/aarp.c:959: for each function it appears in.)
net/appletalk/aarp.c:960: `entry' undeclared (first use in this function)
net/appletalk/aarp.c: At top level:
net/appletalk/aarp.c:1029: `aarp_seq_next' undeclared here (not in a function)
net/appletalk/aarp.c:1029: initializer element is not constant
net/appletalk/aarp.c:1029: (near initialization for `aarp_seq_ops.next')
make[2]: *** [net/appletalk/aarp.o] Error 1
make[1]: *** [net/appletalk] Error 2
make: *** [net] Error 2

-- 
Clemens

