Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293610AbSBZWCo>; Tue, 26 Feb 2002 17:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293609AbSBZWCe>; Tue, 26 Feb 2002 17:02:34 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:51695 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293610AbSBZWCW>;
	Tue, 26 Feb 2002 17:02:22 -0500
Date: Tue, 26 Feb 2002 14:02:20 -0800
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.5 ERROR] Can't compile without NFS
Message-ID: <20020226140220.A17977@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020226120459.A17913@bougret.hpl.hp.com> <15484.787.973914.508508@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15484.787.973914.508508@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Wed, Feb 27, 2002 at 08:50:11AM +1100
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 08:50:11AM +1100, Neil Brown wrote:
> On Tuesday February 26, jt@bougret.hpl.hp.com wrote:
> > make[2]: Entering directory `/usr/src/kernel-source-2.5/fs'
> > gcc -D__KERNEL__ -I/usr/src/kernel-source-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=filesystems  -DEXPORT_SYMTAB -c filesystems.c
> > filesystems.c: In function `sys_nfsservctl':
> > filesystems.c:30: dereferencing pointer to incomplete type
> > filesystems.c:30: dereferencing pointer to incomplete type
> > filesystems.c:30: warning: value computed is not used
> ....
> 
> Yeh... sorry 'bout that.
> 
> Patch sent to Linus, but didn't make it into 2.5.6-pre1.

	That's ok, it was trivial to workaround.

	Jean
