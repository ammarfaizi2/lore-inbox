Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311884AbSCTRrP>; Wed, 20 Mar 2002 12:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSCTRrF>; Wed, 20 Mar 2002 12:47:05 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:46000 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S311884AbSCTRq4>; Wed, 20 Mar 2002 12:46:56 -0500
Message-ID: <3C98CCFB.1080601@wanadoo.fr>
Date: Wed, 20 Mar 2002 18:55:07 +0100
From: eddantes@wanadoo.fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Anton Altaparmakov <aia21@cus.cam.ac.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.7] undefined reference to `sys_nfsservctl'
In-Reply-To: <Pine.SOL.3.96.1020320162809.19016A-100000@draco.cus.cam.ac.uk> <shsd6xztcj8.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Trond Myklebust wrote:

>>>>>>" " == Anton Altaparmakov <aia21@cus.cam.ac.uk> writes:
>>>>>>
> 
>      > Al Viro has a patch for this on his ftp site but you can get
>      > over the compile problemy by simply enabling both nfs and nfs
>      > server in the kernel configuration, no patch needed in that
>      > case... I.e. you want to set these:
> 
>     >> # CONFIG_NFS_FS is not set CONFIG_NFS_V3 is not set CONFIG_NFSD
>     >> # is not set CONFIG_NFSD_V3 is not set
> 
> No point in compile in the NFS client unless you really need it.
> sys_nfsservctl is a knfsd-only thing, so you shouldn't need either
> CONFIG_NFS_FS or CONFIG_NFS_V3 if you only want get around the bug.



Yes, I'd prefer not to compile in stuff I don't need. And I definitely 
don't need NFS.

OTOH, I went on Al Viro's ftp to try to find the patch. Which file is it? :)

/Dantes



