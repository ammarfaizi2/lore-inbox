Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281638AbRKUHE2>; Wed, 21 Nov 2001 02:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281641AbRKUHES>; Wed, 21 Nov 2001 02:04:18 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:20096 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281638AbRKUHEG>; Wed, 21 Nov 2001 02:04:06 -0500
Message-ID: <003401c1725a$975ad4e0$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <jmerkey@vger.timpanogas.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20011121003304.A683@vger.timpanogas.org><20011120.224723.35806752.davem@redhat.com><000601c17259$59316630$f5976dcf@nwfs> <20011120.225655.85404918.davem@redhat.com>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Wed, 21 Nov 2001 00:03:15 -0700
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
From: "David S. Miller" <davem@redhat.com>
To: <jmerkey@timpanogas.org>
Cc: <jmerkey@vger.timpanogas.org>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 20, 2001 11:56 PM
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
opcode


>    From: "Jeff Merkey" <jmerkey@timpanogas.org>
>    Date: Tue, 20 Nov 2001 23:54:21 -0700
>
>    I am building an NWFS module external of the kernel tree, and unless
make
>    dep
>    has been run, the default behavior of the includes causes me to drop
into
>    the
>    BUG() trap.
>
> When you change configuration options, you have to run make
> dep again, that is a known requirement of the 2.4.x build system

OK.  Cool.  Now we are making progress.  I think this is a nasty problem.
There
are numerous RPMs that will build against the kernel tree and be busted.  I
would
expect an rpm -ba on your DEFAULT kernel in Redhat with the sources
contained
in the kernel.rpm files to also be broken unless someone has done this.  You
probably should have someone check this out.  I just built the SCI drivers
against
2.4.15-pre7 and they blow up as well.

Jeff

> like it or not :-)

