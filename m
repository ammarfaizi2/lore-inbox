Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316727AbSERAlI>; Fri, 17 May 2002 20:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316729AbSERAlH>; Fri, 17 May 2002 20:41:07 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:54278 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S316727AbSERAlG>; Fri, 17 May 2002 20:41:06 -0400
Date: Sat, 18 May 2002 10:42:06 +1000
From: john slee <indigoid@higherplane.net>
To: Halil Demirezen <halild@bilmuh.ege.edu.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: To start up
Message-ID: <20020518004206.GB20992@higherplane.net>
In-Reply-To: <Pine.LNX.4.44.0205102313240.8807-100000@bilmuh.ege.edu.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 11:16:04PM +0300, Halil Demirezen wrote:
> I have started to be interested in developing kernels code in a such way .
> But i am interested in the network source codes .. Do i have to know all
> kernel code or just the network section to be a devoloper for the kernel-
> network section-

i don't think anyone really knows "all" kernel code.  have you looked at
just how much code there is?  certainly you should try to understand as
much of the "core" code as possible, as that part is reasonably small
and important.  the rest is either architecture-specific stuff (i386,
sparc), major subsystems (networking, vfs), or drivers (eepro100,
serial).

whats important is gaining a general understanding of how things are
done/what to watch out for in linux kernelville.  for example if you
want to write a network card driver you'd look at how an existing
driver[1] interacts with the rest of the kernel and use that as an
example.  same can be said everywhere else.

hope that helps,

j.

[1] picking the right example is an exercise in itself, maybe look at
    http://kerneljanitor.org/ for some idea of what could be a bad
    example


-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
