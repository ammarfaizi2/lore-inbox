Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbRF2JtC>; Fri, 29 Jun 2001 05:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265803AbRF2Jsx>; Fri, 29 Jun 2001 05:48:53 -0400
Received: from t2.redhat.com ([199.183.24.243]:25589 "EHLO
	whatever.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265816AbRF2Jsj>; Fri, 29 Jun 2001 05:48:39 -0400
Date: Fri, 29 Jun 2001 01:02:24 -0700 (PDT)
From: Bernd Schmidt <bernds@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mikael Pettersson <mikpe@csd.uu.se>, FrankZhu@viatech.com.cn,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:Illegal instruction when mount nfs file systems using
In-Reply-To: <E15Fkwy-0007ps-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0106290100230.29441-100000@whatever.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2001, Alan Cox wrote:

> > Here I have to disagree with you Alan. When you pass "-march=i686" to
> > gcc, you are _not_ saying "generate code for a CPUID family 6 CPU".
> > "-march=i686" actually means "target an Intel P6 family chip, given
> > what we currently know about them". The gcc info pages don't talk
> 
> Which is fine. The Pentium Pro manual explicitly states that cmov may go
> away. So it is not based on what we know about the CPU, its based on not
> reading the documentation. 
> 
> It's a bug. -march=i6868 does not 'target an Intel P6 family chip, ...'
> It happens to work because the error in reading the docs was never triggered
> by intel removing cmov from a cpu as the reserved the right to do

Pedantically you  may be right, but it's not a very useful interpretation of
the situation.  Would it make you happier if -march=i686 was documented as
generating cmov instructions?  IMO it's only a manual bug if at all.


Bernd

