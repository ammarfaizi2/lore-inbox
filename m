Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbRGGVbi>; Sat, 7 Jul 2001 17:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266580AbRGGVb2>; Sat, 7 Jul 2001 17:31:28 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:59655 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S266578AbRGGVbN>;
	Sat, 7 Jul 2001 17:31:13 -0400
Date: Sat, 7 Jul 2001 23:31:08 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Eugene Crosser <crosser@average.org>, linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Message-ID: <20010707233108.B10109@pcep-jamie.cern.ch>
In-Reply-To: <Pine.GSO.4.21.0107070727030.24836-100000@weyl.math.psu.edu> <9i73bg$psv$1@pccross.average.org> <3B471399.1D6BBED6@mandrakesoft.com> <01070719241107.22952@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01070719241107.22952@starship>; from phillips@bonn-fries.net on Sat, Jul 07, 2001 at 07:24:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> > Reading a tarball is the distillation of what you describe into
> > efficient form :)
> 
> /me downloads tar file definition
> 
> Um, gnu tar or posix tar? or some new, improved tar?

I suggest cpio, which is more compact and in some ways more standard.
(tar has a silly pad-to-multiple-of-512-byte per file rule, which is
inappropriate for this).  GNU cpio creates cpio format just fine.

-- Jamie
