Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288986AbSAOQzy>; Tue, 15 Jan 2002 11:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289394AbSAOQzr>; Tue, 15 Jan 2002 11:55:47 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:39607 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288986AbSAOQyr>; Tue, 15 Jan 2002 11:54:47 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 15 Jan 2002 08:54:46 -0800
Message-Id: <200201151654.IAA13233@baldur.yggdrasil.com>
To: davem@redhat.com
Subject: linux-2.5.2/drivers/net/sungem.c uses nonexistant devexit_p macro
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.5.2/drivers/net/sungem.c uses devexit_p, which is not
currently in 2.5.2.  I understand the purpose of devexit_p and I have
kludged around it for myself.  I am just bringing it to your attention
so you can figure out whether to remove the devexit_p reference, have
a workaround for kernels that lack it, or add devexit_p to Linus's tree.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
