Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313392AbSDYUVM>; Thu, 25 Apr 2002 16:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313401AbSDYUVL>; Thu, 25 Apr 2002 16:21:11 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:7767 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313392AbSDYUVL>; Thu, 25 Apr 2002 16:21:11 -0400
Date: Thu, 25 Apr 2002 16:21:06 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: 1279 mounts
Message-ID: <20020425162106.A30736@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I updated my patch that allows to mount unholy numbers of volumes.
The old version was for 2.4.9 and did not apply anymore.
I split the unnamed majors patch and the NFS patch.
Also, CONFIG_ option is gone, because it made the code ugly.

Majors part:
 http://people.redhat.com/zaitcev/linux/linux-2.4.19-pre7-unmaj.diff
NFS part:
 http://people.redhat.com/zaitcev/linux/linux-2.4.19-pre7-nores.diff
Userland for NFS:
 http://people.redhat.com/zaitcev/linux/util-linux-2.11q-nores1.diff

Is anyone actually interested? Random people periodically ask
me for patches, get them and disappear into the void. I hear
nothing good or bad (well, nothing since Trond reviewed it
several months ago, and also someone found a conflict with NFS
server code, since fixed). I am thinking about submitting,
but if users do not ask, why add extra bloat and negotiate
with LANANA...

-- Pete
