Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTEWPGx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 11:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264077AbTEWPGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 11:06:53 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:55876 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264069AbTEWPGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 11:06:52 -0400
Subject: RE: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <002c01c32108$1e4bb980$020b10ac@pitzeier.priv.at>
References: <002c01c32108$1e4bb980$020b10ac@pitzeier.priv.at>
Content-Type: text/plain
Organization: 
Message-Id: <1053703202.16126.25.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 May 2003 11:20:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-23 at 04:48, Oliver Pitzeier wrote:
> [ ... ]
> 
> OK. So now I have to say: _Don't_ use 2.4.20-rc* if you have a aic7xxx. You can
> use 2.4.19 and maybe 2.4.20(?).

2.4.20 is fine for me here... (Its 2.4.20 with the AA highmem-as-lowmem
patch and 1G of ram):

$ head -n 2 /proc/scsi/aic7xxx/[01];uname -a;uptime
==> /proc/scsi/aic7xxx/0 <==
Adaptec AIC7xxx driver version: 6.2.8
aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

==> /proc/scsi/aic7xxx/1 <==
Adaptec AIC7xxx driver version: 6.2.8
aic7880: Ultra Wide Channel B, SCSI Id=7, 16/253 SCBs
Linux oscar 2.4.20 #1 Sun Mar 2 13:09:09 EST 2003 i686 unknown unknown
GNU/Linux
 11:20:24 up 53 days, 19:33, 30 users,  load average: 0.14, 0.19, 0.20

-- 
Disconnect <lkml@sigkill.net>

