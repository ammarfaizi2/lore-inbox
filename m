Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283215AbRLDRng>; Tue, 4 Dec 2001 12:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281153AbRLDRmU>; Tue, 4 Dec 2001 12:42:20 -0500
Received: from [195.63.194.11] ([195.63.194.11]:17678 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281157AbRLDRkz>; Tue, 4 Dec 2001 12:40:55 -0500
Message-ID: <3C0D0845.6FA6FBFD@evision-ventures.com>
Date: Tue, 04 Dec 2001 18:30:45 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@caldera.de>,
        Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <20011204173309.A10746@emma1.emma.line.org> <E16BJ9v-0002ii-00@the-village.bc.nu> <20011204121950.E16578@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > > Creating a dependency on Python? Is a non-issue. Current systems that
> > > are to run 2.5 or 2.6 are bloated beyond belief by glibc already, Python
> > > is nice and it does not create such unmaintainable mess. Whether
> >
> > Python2 - which means most users dont have it.
> 
> I'm pretty sure that's true any more, Alan.  Red Hat shipped Python 2 in
> 7.1, so the RPM-based distros like KRUD and Mandrake have had it for
> seven months. Debian had it before that.
> 
> Requiring 2.0 looked aggressive when I did it, but it wasn't -- I could
> safely project that it would be deployed everywhere except on a set of
> measure zero by the time the actual cutover happened.

~# rpm -qa | grep -i python
python-1.5.2-35
python-xmlrpc-1.5.0-1
pythonlib-1.28-1
rpm-python-4.0.3-1.03
python-devel-1.5.2-35

Just another megaton unnecessary programming language to compile
somehting like the kernel? I think you are exaggerating the problem.
