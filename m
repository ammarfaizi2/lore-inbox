Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292045AbSBTQ5P>; Wed, 20 Feb 2002 11:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292036AbSBTQ5I>; Wed, 20 Feb 2002 11:57:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39698 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292031AbSBTQ4x>;
	Wed, 20 Feb 2002 11:56:53 -0500
Message-ID: <3C73D548.648C5D64@mandrakesoft.com>
Date: Wed, 20 Feb 2002 11:56:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Peter J. Braam" <braam@clusterfs.com>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, phil@off.net
Subject: Re: tmpfs, NFS, file handles
In-Reply-To: <20020220094649.X25738@lustre.cfs>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter J. Braam" wrote:
> 
> Hi,
> 
> At present one can probably not run NFS (or InterMezzo) on top of
> tmpfs.
> 
> Is there a suggested solution for fh_to_dentry and dentry_to_fh for
> tmpfs?
> 
> An "iget" based solution might work but at present tmpfs inodes are
> not hashed.

I talked to neil brown about NFS and ramfs... he mentioned using
iunique()

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
