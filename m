Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281966AbRKUTzE>; Wed, 21 Nov 2001 14:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281965AbRKUTyx>; Wed, 21 Nov 2001 14:54:53 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:8068 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281961AbRKUTyp>; Wed, 21 Nov 2001 14:54:45 -0500
Message-ID: <002801c172c6$3e23a8e0$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Arjan van de Ven" <arjan@fenrus.demon.nl>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E166S8l-0007hs-00@fenrus.demon.nl> <002401c172ba$b46bed20$f5976dcf@nwfs> <20011121191607.A32418@fenrus.demon.nl>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Wed, 21 Nov 2001 12:53:51 -0700
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


----- Original Message -----
From: "Arjan van de Ven" <arjan@fenrus.demon.nl>
To: "Jeff Merkey" <jmerkey@timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 21, 2001 12:16 PM
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
opcode


> On Wed, Nov 21, 2001 at 11:31:15AM -0700, Jeff Merkey wrote:
>
> > I would anticipate seeing this problem with their kernel source RPM.  In
> > fact, I do, you have to do a make distclean before you can use it
because
> > of the way their rpm script munges all the versioned trees into a tmp
area
> > during RPM creation. There's only one source tree (usually the last one
> > they built) and lots of binary rpm versions from the one tree (i.e.
i386,
> > i686, etc.).
>
> Yes and during the build the modversions and depenency info  etc for each
> version is nicely stored in separate directories which is later combined
> into one tree with #if's for the proper currently running kernel.
>
> Have you even looked at the kernel-source RPM ?

Yes.  I based a Linux distribution on RedHat's 6.2 last year, and I am
**VERY** familiar with your anaconda installer and kernel.src.rpm build
modules.  I know the 7.X stuff got a hell of a lot better, but customers
still have to sterilize the build area are your rpm gets installed in order
to build external kernel modules.

Jeff

>
> Greetings,
>   Arjan van de Ven
>   Red Hat Linux kernel maintainer

