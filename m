Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129529AbQKWBot>; Wed, 22 Nov 2000 20:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132306AbQKWBoi>; Wed, 22 Nov 2000 20:44:38 -0500
Received: from Cantor.suse.de ([194.112.123.193]:35083 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S129529AbQKWBoT>;
        Wed, 22 Nov 2000 20:44:19 -0500
Date: Thu, 23 Nov 2000 02:14:17 +0100
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: include conventions /usr/include/linux/sys ?
Message-ID: <20001123021417.A1602@gruyere.muc.suse.de>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHOEKLCJAA.law@sgi.com> <8vhhnv$j0d$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8vhhnv$j0d$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Nov 22, 2000 at 02:35:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2000 at 02:35:43PM -0800, H. Peter Anvin wrote:
> Followup to:  <NBBBJGOOMDFADJDGDCPHOEKLCJAA.law@sgi.com>
> By author:    "LA Walsh" <law@sgi.com>
> In newsgroup: linux.dev.kernel
> >
> > Linus has mentioned a desire to move kernel internal interfaces into
> > a separate kernel include directory.  In creating some code, I'm wondering
> > what the name of this should/will be.  Does it follow that convention
> > would point toward a linux/sys directory?
> > 
> 
> I suggested include/kernel and include/arch with include/linux and
> include/asm being reserved for the kernel interfaces (ioctl and their
> structures mostly.)

It would also be useful to put *32 structures for 32->64bit conversion
in there (to prepare for a generic 32->64bit conversion layer in 2.5) 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
