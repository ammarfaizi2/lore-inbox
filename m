Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbRAXN3v>; Wed, 24 Jan 2001 08:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131737AbRAXN3l>; Wed, 24 Jan 2001 08:29:41 -0500
Received: from [63.95.87.168] ([63.95.87.168]:3347 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S130153AbRAXN3b>;
	Wed, 24 Jan 2001 08:29:31 -0500
Date: Wed, 24 Jan 2001 08:29:30 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Daniel Phillips <phillips@innominate.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1542!(2.4.1-pre9)
Message-ID: <20010124082929.A1970@xi.linuxpower.cx>
In-Reply-To: <3A6C5058.C5AA7681@zaralinux.com> <3A6CB620.469A15A9@Home.net> <3A6ED16E.E8343678@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3A6ED16E.E8343678@innominate.de>; from phillips@innominate.de on Wed, Jan 24, 2001 at 01:58:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 01:58:22PM +0100, Daniel Phillips wrote:
> > This is not a kernel bug, This is a bug in the XFree86 TrueType rendering
> > extention. This has been discussed on the Xpert XFree86 mailing list. There
> > is a fix in the works (depends on the TrueType fonts your using).
> 
> A BUG is a BUG:
>  
> > > kernel BUG at slab.c:1542!
> 
> The kernel should never oops, no matter what user space does to it.

The kernel appears to run fine with this bug() removed.

BTW- gimp and a few other apps also manage to trigger it..
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
