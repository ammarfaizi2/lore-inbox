Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281942AbRKUSaS>; Wed, 21 Nov 2001 13:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281451AbRKUSaJ>; Wed, 21 Nov 2001 13:30:09 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:36995 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281941AbRKUS36>; Wed, 21 Nov 2001 13:29:58 -0500
Message-ID: <001d01c172ba$5b4497b0$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Kai Henningsen" <kaih@khms.westfalen.de>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20011120.222203.58448986.davem@redhat.com> <davem@redhat.com> <20011121001639.A813@vger.timpanogas.org> <20011120.222203.58448986.davem@redhat.com> <20011121003304.A683@vger.timpanogas.org> <8DGB4I5Hw-B@khms.westfalen.de>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Wed, 21 Nov 2001 11:28:46 -0700
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
From: "Kai Henningsen" <kaih@khms.westfalen.de>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 20, 2001 11:47 PM
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
opcode


> jmerkey@vger.timpanogas.org (Jeff V. Merkey)  wrote on 21.11.01 in
<20011121003304.A683@vger.timpanogas.org>:
>
> > download pre7, apply my patch, and do the build.  I went back
> > over how I did the build, and this is the result of the build
> > if you have unpacked, patched, then run "make oldconfig."  If I
> > do a "make dep" then this problem does not occur, and the build
>
> Isn't that exactly the FAQ Keith points out every other day or so (usually
> because of a modprobe "symbol not found"), one of the design bugs that
> kbuild 2.5 fixes (i.e., the kernel does not notice when it needs to make
> dep, so kbuild 2.5 handles dependencies differently)?
>
> MfG Kai

This is good news on the dependency methods.

Jeff

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

