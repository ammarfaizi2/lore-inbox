Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272449AbRJDIeR>; Thu, 4 Oct 2001 04:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272882AbRJDIeJ>; Thu, 4 Oct 2001 04:34:09 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:39947 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S272449AbRJDId4>; Thu, 4 Oct 2001 04:33:56 -0400
Date: Thu, 4 Oct 2001 18:35:07 +1000
From: john slee <indigoid@higherplane.net>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011004183507.A29887@higherplane.net>
In-Reply-To: <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu> <m14rpg0w4a.fsf@frodo.biederman.org> <20011004182127.B512@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011004182127.B512@zip.com.au>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ cc list trimmed ]

On Thu, Oct 04, 2001 at 06:21:27PM +1000, CaT wrote:
> On Thu, Oct 04, 2001 at 12:15:01AM -0600, Eric W. Biederman wrote:
> > I have days when I'm frustrated by the size of both glibc and the
> > linux kernel.  stripped both the linux kernel and glibc are comparable
> > in size.  Though I think the 400KB of compressed glibc-2.1.2 is
> > actually smaller than the kernel for the most part.  I have to strip
> > off practically everthing to get a useable bzImage under 400KB.
> > 
> > So any good ideas on how to get the size of linux down?
> 
> Mind if I ask why you need a bzimage under 400kb? Just curious as I've
> never had the need. (And I can see needing it less then 1.4meg - are you
> trying to get a kernel AND a ramdisk on the one floppy?)

plenty of reasons.  i'm building a compactflash-based linux router which
will only have 16mb of flash for the entire system... saving 100kb means
you can fit a few extra userspace tools in there...

-rwxr-xr-x    1 indigoid indigoid    54444 Oct  4 18:30 boa*

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
