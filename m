Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBGIiT>; Wed, 7 Feb 2001 03:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129791AbRBGIiJ>; Wed, 7 Feb 2001 03:38:09 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:17025 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129028AbRBGIiA>; Wed, 7 Feb 2001 03:38:00 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.05.10102062344490.31995-100000@ns.roland.net> 
In-Reply-To: <Pine.LNX.4.05.10102062344490.31995-100000@ns.roland.net> 
To: Jim Roland <jroland@roland.net>
Cc: "J. Dow" <jdow@earthlink.net>, linux-kernel@vger.kernel.org
Subject: Re: RedHat kernel RPM 2.2.16 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Feb 2001 08:37:45 +0000
Message-ID: <16718.981535065@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jroland@roland.net said:
>  FWIW, the rpm -i did unpack the kernel to the /usr/src/redhat/SOURCES
> directory, however, I had to manually untar the sources to /usr/src to
> get my kernel, move over the appropriate .config file, and manually
> run the patches to patch the sources.  Forcing RPM to be very
> talkative (via -vv) gave me a bunch of "action unknown" errors, and
> the rpm's install scripts did not execute.  This occurs on an RH7
> system as well.  Seems to be something wrong with RH's kernel rpm? 

Install the kernel-source binary RPM, which contains the build tree already 
extracted and set up as you desire, instead of the master SRPM which 
contains build instructions for all the kernel versions.

i.e. kernel-source-2.2.16-3.i386.rpm, not kernel-2.2.16-3.src.rpm

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
