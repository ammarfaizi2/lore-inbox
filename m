Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWFJOn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWFJOn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 10:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbWFJOn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 10:43:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:60933 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030430AbWFJOnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 10:43:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cfvCtLOy8Rf53FYqlmxXv20gGiyMveCPl/Hf3ja1ZgR8XBbgN0FA92BOaBtqCnMw7sC0fwhmzSsUQmFFj11U1pDlWcT3ccvxOgnZp5NRqCsfBHYEqFxA6p+lzlyBe1z8BAw8NSsq3n8pAr07WLqnhS+o9F7jpWxtbIZjYvhj8ZA=
Message-ID: <6bffcb0e0606100743i3963a008rd907879bf5f1e9da@mail.gmail.com>
Date: Sat, 10 Jun 2006 16:43:54 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: tglx@linutronix.de
Subject: Re: 2.6.17-rc6-rt3
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0606100630k1b7082c7na123a513d853fb13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060610082406.GA31985@elte.hu>
	 <6bffcb0e0606100332t9f305c8ubbc715db7956510e@mail.gmail.com>
	 <1149943465.5257.199.camel@localhost.localdomain>
	 <6bffcb0e0606100630k1b7082c7na123a513d853fb13@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi Thomas,
>
> On 10/06/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Michal,
> >
> > On Sat, 2006-06-10 at 12:32 +0200, Michal Piotrowski wrote:
> > > My system hangs on boot.
> >
> > It boots fine with your config here :(. Any chance to get a full output
> > via serial console ?
>
> Currently not. I'll buy serial cable.
>

Everything is ok when I build a kernel with gcc 4.1
[michal@ltg01-fedora ~]$ gcc -v
Using built-in specs.
Target: i386-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info --enable-shared --enable-threads=posix
--enable-checking=release --with-system-zlib --enable-__cxa_atexit
--disable-libunwind-exceptions --enable-libgcj-multifile
--enable-languages=c,c++,objc,obj-c++,java,fortran,ada
--enable-java-awt=gtk --disable-dssi
--with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre
--with-cpu=generic --host=i386-redhat-linux
Thread model: posix
gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)

Can you try build a kernel with gcc 3.4.6?

[michal@ltg01-fedora ~]$ gcc-3.4 -v
Reading specs from /usr/local/bin/../lib/gcc/i686-pc-linux-gnu/3.4.6/specs
Configured with: ./configure --prefix=/usr/local/ --disable-nls
--enable-shared --enable-languages=c --program-suffix=-3.4
Thread model: posix
gcc version 3.4.6

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
