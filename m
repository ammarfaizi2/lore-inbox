Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287924AbSA0KIe>; Sun, 27 Jan 2002 05:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287933AbSA0KIZ>; Sun, 27 Jan 2002 05:08:25 -0500
Received: from mx3.sac.fedex.com ([199.81.208.11]:49680 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S287924AbSA0KIR>; Sun, 27 Jan 2002 05:08:17 -0500
Date: Sun, 27 Jan 2002 18:08:45 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@fedex.com>
Subject: 2.4.18-pre7 slow ... apm problem
Message-ID: <Pine.LNX.4.44.0201271804160.907-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/27/2002
 06:08:13 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/27/2002
 06:08:15 PM,
	Serialize complete at 01/27/2002 06:08:15 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Found the problem.

After disabling CONFIG_APM_CPU_IDLE, the system works fast again.

With pre6 or earlier versions, system works fine though even with
CONFIG_APM_CPU_IDLE enabled.

System is IBM X22 800MHz notebook, 640MB ram.

Thanks,
Jeff
[ jchua@fedex.com ]

---------- Forwarded message ----------
Date: Sun, 27 Jan 2002 14:49:06 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.18-pre7 slow



1) keyboard rate is a bit slow on 2.4.18-pre7 compared to 2.4.18-pre6.

2) On vmware 3.0, ping localhost is very slow. 2.4.18-pre6 has not such
problem.


Thanks,
Jeff
[ jchua@fedex.com ]


