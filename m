Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263118AbREaRKs>; Thu, 31 May 2001 13:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbREaRKi>; Thu, 31 May 2001 13:10:38 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:35847 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263118AbREaRK2>; Thu, 31 May 2001 13:10:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Date: Thu, 31 May 2001 19:12:17 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> <20010531013827.J16761@parcelfarce.linux.theplanet.co.uk> <p0510031ab73b43e89d24@[10.128.7.49]>
In-Reply-To: <p0510031ab73b43e89d24@[10.128.7.49]>
MIME-Version: 1.0
Message-Id: <0105311912171L.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 May 2001 02:44, Jonathan Lundell wrote:
> At 1:38 AM +0100 2001-05-31, Joel Becker wrote:
> >On Wed, May 30, 2001 at 05:24:37PM -0700, Jonathan Lundell wrote:
> >>  FWIW (perhaps not much in this context), the POSIX way is
> >>sysconf(_SC_CLK_TCK)
> >>
> >>  POSIX sysconf is pretty useful for this kind of thing (not just
> >> HZ, either).
> >
> >	Well, how many hundred things on Linux are available from /proc
> >but not from sysconf or the like?  :-)
>
> Lots. Maybe we oughta have /proc/sysconf/... (there's no reason
> sysconf() can't be a library reading /proc).

The other way round would make more sense.

--
Daniel
