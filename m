Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319262AbSIKSTd>; Wed, 11 Sep 2002 14:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319263AbSIKSTd>; Wed, 11 Sep 2002 14:19:33 -0400
Received: from [209.184.141.189] ([209.184.141.189]:31161 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S319262AbSIKSTc>;
	Wed, 11 Sep 2002 14:19:32 -0400
Subject: Re: 2.4.20pre5aa2
From: Austin Gonyou <austin@coremetrics.com>
To: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, linux-xfs@oss.sgi.com
In-Reply-To: <20020911201602.A13655@pc9391.uni-regensburg.de>
References: <20020911201602.A13655@pc9391.uni-regensburg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Coremetrics, Inc.
Message-Id: <1031768655.24629.23.camel@UberGeek.coremetrics.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 11 Sep 2002 13:24:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you try just using insmod, instead of modprobe. To use modprobe,
your module must have something defined in /etc/modules.conf


On Wed, 2002-09-11 at 13:16, Christian Guggenberger wrote:
> Hi!
> 
> just tried out 2.4.20-pre5aa2 with xfs enabled as module. But I can't
> load 
> the xfs Module...
> modprobe xfs just won't work. Via top on another console I see two
> modpobe 
> processes, each consuming 99.9% CPU time. Then, after a minute or so,
> the 
> machine reboots...
> 
> System is a Dell Precision with 2 Intel Xeons@2.2GHz and 2GB RDRAM and
> hyper-threading enabled, OS is Debian/GNU Linux 3.0 with:
> 
> gcc-2.95.4 20011002 (Debian prerelease)
> ld-2.12.90.0.1 20020307 Debian/GNU Linux
> 
> 
> I tried to disable HT, but then it was even worse. Then my machine
> crashed 
> hard after starting "modprobe xfs".
> 
> 
> thanks in advance
> Christian
> 
> P.S. if needed, I could post my .config, or other relevant things...
>   
-- 
Austin Gonyou <austin@coremetrics.com>
Coremetrics, Inc.
