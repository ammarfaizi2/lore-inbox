Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272301AbRHXTAe>; Fri, 24 Aug 2001 15:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272302AbRHXTAO>; Fri, 24 Aug 2001 15:00:14 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:33164 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S272301AbRHXTAF>; Fri, 24 Aug 2001 15:00:05 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Denis Perchine <dyp@perchine.com>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 24 Aug 2001 10:42:35 -0700 (PDT)
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
In-Reply-To: <20010824020119.42D951FD7D@mx.webmailstation.com>
Message-ID: <Pine.LNX.4.33.0108241041340.5666-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

let's see you remove perl, python, etc but are going to leave gcc on there
so you can compile kernels there????

if you are really locking a box down like that you will compile the kernel
on another machine and so will not need gcc or python on the box.

David Lang

On Fri, 24 Aug 2001, Denis Perchine wrote:

> Date: Fri, 24 Aug 2001 11:59:41 +0700
> From: Denis Perchine <dyp@perchine.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
>
> On Friday 24 August 2001 02:41, Tom Rini wrote:
> > On Thu, Aug 23, 2001 at 09:26:33PM +0200, Jes Sorensen wrote:
> > > >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
> > You've said this before. :)  Just how small of an 'embedded' system are
> > you talking about?  I know of people who do compile a kernel now and
> > again on a 'small' system, for fun.  On a larger (cPCI) system, I
> > don't see your point.  If you can somehow transport the 21mb[1] bzip2
> > kernel source to your system, you can transport python.  If you're
> > porting to a brand new arch, there's still good tests before you
> > have shlib support (You've mentioned that before too I think).
>
> There is another point why having Python installed is a problem. Usually when
> you install a server you remove everything from it because of space, and
> security reasons. The main security concern is the less is installed the
> better security is. I always remove python from any servers I have. As I
> remove guile, forth, and other useless (in terms of server) languages. Now
> you tell me that I should have this bloat installed just to configure my
> kernel. Do not you think that it is too much? Current kernel does not require
> anything like this.
>
> --
> Sincerely Yours,
> Denis Perchine
>
> ----------------------------------
> E-Mail: dyp@perchine.com
> HomePage: http://www.perchine.com/dyp/
> FidoNet: 2:5000/120.5
> ----------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
