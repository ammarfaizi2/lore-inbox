Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274656AbRITVRT>; Thu, 20 Sep 2001 17:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274654AbRITVRI>; Thu, 20 Sep 2001 17:17:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35492 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274591AbRITVQy>;
	Thu, 20 Sep 2001 17:16:54 -0400
Date: Thu, 20 Sep 2001 17:17:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Bornemann <eduard.epi@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: noexec-flag does not work in Linux 2.4.10-pre10
In-Reply-To: <Pine.LNX.4.33.0109201957530.2448-100000@eduard.t-online.de>
Message-ID: <Pine.GSO.4.21.0109201715100.5631-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Peter Bornemann wrote:

> It seems that the noexec in fstab no longer works. Is this
> intentional?
> 
> In fstab I have the following line:
> 
> /dev/hda1       /dosc   vfat    codepage=850,umask=000,noexec 0 0
> 
> A ls -l in /dosc shows:
> 
> -rwxrwxrwx    1 root     root     267657216 Jun 28 22:34 win386.swp

... and?  What happens if you do cp /bin/ls /dosc && /dosc/ls ?

