Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281979AbRKUVT2>; Wed, 21 Nov 2001 16:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281981AbRKUVTU>; Wed, 21 Nov 2001 16:19:20 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:9088 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281979AbRKUVTK>; Wed, 21 Nov 2001 16:19:10 -0500
Message-ID: <002201c172d1$ca81cc80$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Doug Ledford" <dledford@redhat.com>
Cc: "Arjan van de Ven" <arjan@fenrus.demon.nl>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E166S8l-0007hs-00@fenrus.demon.nl> <002401c172ba$b46bed20$f5976dcf@nwfs> <20011121191607.A32418@fenrus.demon.nl> <002801c172c6$3e23a8e0$f5976dcf@nwfs> <3BFC1051.1050201@redhat.com>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Wed, 21 Nov 2001 14:16:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which kernel version?  Neither NWFS or SCI will build against "stock"
installed kernel sources provided with Seawolf.

Jeff


----- Original Message -----
From: "Doug Ledford" <dledford@redhat.com>
To: "Jeff Merkey" <jmerkey@timpanogas.org>
Cc: "Arjan van de Ven" <arjan@fenrus.demon.nl>;
<linux-kernel@vger.kernel.org>
Sent: Wednesday, November 21, 2001 1:36 PM
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
opcode


> Jeff Merkey wrote:
>
> >>Have you even looked at the kernel-source RPM ?
> >>
> >
> > Yes.  I based a Linux distribution on RedHat's 6.2 last year, and I am
> > **VERY** familiar with your anaconda installer and kernel.src.rpm build
> > modules.  I know the 7.X stuff got a hell of a lot better, but customers
> > still have to sterilize the build area are your rpm gets installed in
order
> > to build external kernel modules.
>
>
> <sigh>  Again, this isn't true.  I build modules against our
> kernel-source RPM tree all the time, and I *never* do a make distclean.
>   If I did, it would screw the tree permanently.  If you are basing your
> arguments about what you saw with 6.2, then you are sorely out of date
> (hell, that was still a 2.2 kernel system).  Things have improved a lot
> since then.  The one overridding rule of working with a tree like we
> ship though, is *NEVER* do anything in the tree itself.  That tree is
> assembled to provide *ALL* the kernel versions and includes for all the
> kernels we ship.  However, even doing a make dep in the tree will blow
> important parts away.  Download my module build kit and see what I'm
> talking about because you currently obviously *don't* know what I'm
> talking about.
>
>
>
>
> --
>
>   Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
>        Please check my web site for aic7xxx updates/answers before
>                        e-mailing me about problems

