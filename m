Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131652AbRCOHK4>; Thu, 15 Mar 2001 02:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131653AbRCOHKq>; Thu, 15 Mar 2001 02:10:46 -0500
Received: from magic.merlins.org ([204.80.113.97]:42500 "EHLO
	magic.merlins.org") by vger.kernel.org with ESMTP
	id <S131652AbRCOHKc>; Thu, 15 Mar 2001 02:10:32 -0500
Date: Wed, 14 Mar 2001 23:09:32 -0800
From: "H . J . Lu" <hjl@gnu.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Chris Jensen <dr_spirograph@technologist.com>,
        NFS maillist <nfs@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] New files on read only NFS mount
Message-ID: <20010314230932.A29059@gnu.org>
In-Reply-To: <001a01c0aac0$80432260$0100a8c0@chris> <shs8zmbksxo.fsf@charged.uio.no> <001601c0ab02$df976860$0100a8c0@chris> <15020.58260.471102.944034@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <15020.58260.471102.944034@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Mar 12, 2001 at 03:56:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2001 at 03:56:20PM +0100, Trond Myklebust wrote:
> >>>>> " " == Chris Jensen <christopher.jensen@studentmail.newcastle.edu.au> writes:
> 
>     >> Details please, the minimum info required being 'which kernel
>     >> is your client running'?
>     >>
> 
>      > Oh yeah, whoops, sorry The server is a 586 and the client is
>      > 686.  They're both using nfs-utils 0.2.1, under linux 2.4.0
>      > with NFS v3 enabled, with glibc 2.2.1 The pertinent line in
>      > /etc/exports is / 192.168.0.1(rw,no_root_squash)
> 
> How does the following patch work out?
> 

I can duplicate the problem and this patch fixes it.


Thanks.

H.J.
