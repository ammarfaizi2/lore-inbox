Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSJ0O46>; Sun, 27 Oct 2002 09:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSJ0O46>; Sun, 27 Oct 2002 09:56:58 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:9166 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262415AbSJ0O44> convert rfc822-to-8bit; Sun, 27 Oct 2002 09:56:56 -0500
Subject: Re: Swap doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?Vladim=EDr?= T =?ISO-8859-1?Q?T=FD?= 
	<guru@cimice.yo.cz>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clock@atrey.karlin.mff.cuni.cz
In-Reply-To: <000801c27dc8$044f43f0$4500a8c0@cybernet.cz>
References: <002501c27da9$2524d0f0$4500a8c0@cybernet.cz>
	<20021027125021.GA1578@riesen-pc.gr05.synopsys.com>
	<1035724348.30403.15.camel@irongate.swansea.linux.org.uk> 
	<000801c27dc8$044f43f0$4500a8c0@cybernet.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Oct 2002 15:21:15 +0000
Message-Id: <1035732075.30551.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-27 at 14:48, Vladimír Tøebický wrote:
> > > That's not a badblock. That's an kernel IDE bug. Andre Hedrick and Alan
> > > Cox will love to see this.
> >
> > Not on a kernel built with an untrusted hand built tool chain
> >
> Well, I don't know what could possibly cause this kind of error except
> kernel.
> No matter what application I use to read or write /dev/hda6. Which part
> of my tool chain do you have in mind?

gcc and binutils. I get so many weird never duplicated reports from
linux from scratch people that don't happen to anyone else that I treat
them with deep suspicion.  Especially because it sometimes goes away if
they instead build the same kernel with Debian/Red Hat/.. binutils/gcc

