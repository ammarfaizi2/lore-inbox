Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131279AbRCHGBU>; Thu, 8 Mar 2001 01:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131281AbRCHGBK>; Thu, 8 Mar 2001 01:01:10 -0500
Received: from dfw-smtpout1.email.verio.net ([129.250.36.41]:35991 "EHLO
	dfw-smtpout1.email.verio.net") by vger.kernel.org with ESMTP
	id <S131279AbRCHGA4>; Thu, 8 Mar 2001 01:00:56 -0500
Message-ID: <3AA71FFD.717F56CE@bigfoot.com>
Date: Wed, 07 Mar 2001 22:00:29 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre8+IDE i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sightler <ttsig@tuxyturvy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Questions about Enterprise Storage with Linux
In-Reply-To: <E14an7j-0001rZ-00@the-village.bc.nu> <20010307164052.B788@wirex.com> <006301c0a765$3ca118e0$1601a8c0@zeusinc.com> <01030720460701.06635@tabby> <000f01c0a778$6ef862e0$1601a8c0@zeusinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler wrote:
> ...
> For example if we purchase a NetApp Filer, or EMC Celerra with 1TB of
> storage, and elect to export that entire amount as a single NFS mount, and
> then use that storage to allow several Linux boxes to share 100GB
> (admittedly temporary) files, will Linux handle that, at least in theory?

Linux/NFS works very well with Filers.  I did a lot of throughput
testing at Netapp circa 2.2.10-12 with Gigabit Ethernet (AceNIC).  Why
would you need to put 1TB on a single mount point?

Filers are also blessed by Oracle and can take care of the volume
management and backup issues.  The principle advantage is avalibility
(balanced against cost of course).  If you do talk to Netapp, ask for
someone that has linux/Filer experience.

rgds,
tim.

--
