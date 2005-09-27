Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbVI0WHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVI0WHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbVI0WHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:07:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:52693 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965187AbVI0WHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:07:14 -0400
Subject: setting PF_ flags from user space PF_LESS_THROTTLE
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1127858515.6120.3.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Sep 2005 17:01:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to see if PF_LESS_THROTTLE would be helpful for Samba to set(as
it is for nfsd, which sets it directly in kernel) to avoid loopback
mount hangs when low on memory.

Any idea whether the task flags, in particular PF_LESS_THROTTLE could be
set from user space (I did not see an obvious way, short of invoking a
new kernel helper, which does not exist, to set it on user space's
behalf)?

