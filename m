Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314987AbSD2Kj3>; Mon, 29 Apr 2002 06:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315039AbSD2Kj2>; Mon, 29 Apr 2002 06:39:28 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:23793 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S314987AbSD2Kj0>; Mon, 29 Apr 2002 06:39:26 -0400
Message-ID: <3CCD22DD.E263949B@redhat.com>
Date: Mon, 29 Apr 2002 11:39:25 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-0.24smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Giacomo Catenazzi <cate@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Microcode update driver
In-Reply-To: <fa.fn3ukrv.1ghovg0@ifi.uio.no> <fa.hho4jnv.11lkl19@ifi.uio.no> <3CCD0B66.4040107@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi wrote:
> 
> arjan@fenrus.demon.nl wrote:
> 
> > In article <m171Yag-000Ga6C@Wasteland> you wrote:
> >
> >>On Saturday 27 April 2002 7:57 pm, Roy Sigurd Karlsbakk wrote:
> >>
> >>>Sorry if this is a FAQ, but where's the microcode.dat supposed to be
> >>>placed? I can't find any information about that in the doc.
> >>>
> >>/usr/share/misc/microcode.dat
> >>
> >
> > hum doesn't the FHS specify that /usr/share shouldn't contain arch
> > specific files ? microcode.dat I can't really call arch neutral....
> 
> Right! But is not a configuration file (in /etc/, like the original sources
> and RH). So it should be in /usr/lib (or in /usr/include, it is really a C/C++
> file, but now we don't use it as a C file).

It's an ascii file for "configuring" the cpu. So I put it in /etc, some
sound firmware
is there anyway (not shipped by RHL but some vendors put it there)

 
> PS: Do you maintain the RH kernel-utils ?

yes

 
> [1] until I find a good new location in FHS

Once I hear a good FHS location I'll change it over to it as well,
/etc/firmware sounded as good as any to me ;(
