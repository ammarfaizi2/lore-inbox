Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTDHBhE (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 21:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTDHBhE (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 21:37:04 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:19915 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263723AbTDHBhD (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 21:37:03 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Ford <david+powerix@blue-labs.org>
Date: Tue, 8 Apr 2003 09:17:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16018.1797.59286.752771@notabene.cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Oleg Drokin <green@namesys.com>, Hans Reiser <reiser@namesys.com>
Subject: Re: [OOPS] 100% repeatable OOPS, 2.5.61-66, NFS and reiserfs
In-Reply-To: message from David Ford on Tuesday April 8
References: <3E92F953.8080401@blue-labs.org>
X-Mailer: VM 7.13 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 8, david+powerix@blue-labs.org wrote:
> 1. Power loss this morning
> 2. Fixed filesystems (reiserfstools is fscking useless on root filesystems)
> 3. Now server OOPSes when nfs client tries to stat/read files/dirs
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> 00000000
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0060:[<00000000>]    Not tainted

Development kernels are like that....

 This is a bug in the kernel which is triggered by using nfs-utils
 1.0.3

 Either upgrade to the latest 2.5 kernel, or downgrade nfs-utils until
 you can upgrade the kernel.

NeilBrown
