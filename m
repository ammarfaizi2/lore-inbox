Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSDZI0D>; Fri, 26 Apr 2002 04:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313712AbSDZI0C>; Fri, 26 Apr 2002 04:26:02 -0400
Received: from cs145025.pp.htv.fi ([213.243.145.25]:22799 "EHLO chip.2y.net")
	by vger.kernel.org with ESMTP id <S313711AbSDZI0C>;
	Fri, 26 Apr 2002 04:26:02 -0400
Date: Fri, 26 Apr 2002 11:25:33 +0300 (EEST)
From: Panu Matilainen <pmatilai@welho.com>
X-X-Sender: pmatilai@chip.2y.net
To: Pete Zaitcev <zaitcev@redhat.com>
cc: nfs@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: 1279 mounts
In-Reply-To: <20020425162106.A30736@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0204261120520.19032-100000@chip.2y.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2002, Pete Zaitcev wrote:

> I updated my patch that allows to mount unholy numbers of volumes.
> The old version was for 2.4.9 and did not apply anymore.
> I split the unnamed majors patch and the NFS patch.
> Also, CONFIG_ option is gone, because it made the code ugly.
> 
> Majors part:
>  http://people.redhat.com/zaitcev/linux/linux-2.4.19-pre7-unmaj.diff
> NFS part:
>  http://people.redhat.com/zaitcev/linux/linux-2.4.19-pre7-nores.diff
> Userland for NFS:
>  http://people.redhat.com/zaitcev/linux/util-linux-2.11q-nores1.diff
> 
> Is anyone actually interested? Random people periodically ask
> me for patches, get them and disappear into the void. I hear
> nothing good or bad (well, nothing since Trond reviewed it
> several months ago, and also someone found a conflict with NFS
> server code, since fixed). I am thinking about submitting,
> but if users do not ask, why add extra bloat and negotiate
> with LANANA...

I've got quite a few users here who "need" this functionality and it's 
included in our RH-based custom kernels. Having it as a separate patch 
for 2.4 is no problem, for 2.5 I'm hoping we finally move to 32bit device 
numbers...

	- Panu -

