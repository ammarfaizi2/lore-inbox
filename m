Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbSI0TIV>; Fri, 27 Sep 2002 15:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262601AbSI0TIU>; Fri, 27 Sep 2002 15:08:20 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:46860 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262596AbSI0TIS>; Fri, 27 Sep 2002 15:08:18 -0400
Date: Fri, 27 Sep 2002 15:13:17 -0400
From: Ben Collins <bcollins@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@sgi.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix drm ioctl ABI default
Message-ID: <20020927191316.GA564@phunnypharm.org>
References: <20020927212752.E4733@sgi.com> <1033153674.16726.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033153674.16726.10.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 08:07:54PM +0100, Alan Cox wrote:
> On Sat, 2002-09-28 at 02:27, Christoph Hellwig wrote:
> > Add a config option to make the i810 drm ioctl ABI XFree4.1 compatible
> > by default (currently that's a module parameter).  The XFree folks fucked
> > this up by adding members in the middle of a struct and we have to work
> > around it now.  At least we should have the pre-2.4.20 behaviour as default.
> > (And I'd suggest you add that option as y to the defconfig)
> 
> With all the vendors now shipping 4.2 this seems a bad thing to default
> to the 4,1 interface - especially as the 4.1 server is

No, not all vendors are shipping 4.2 yet.

> o Buggy
> o Has security holes that are fixed in 4.2.1 only

...or patched onto 4.1.x from 4.2 source.

4.1 is still out in the wild for most ppl.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
