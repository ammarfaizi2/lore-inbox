Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbREaBTX>; Wed, 30 May 2001 21:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262949AbREaBTO>; Wed, 30 May 2001 21:19:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:18193 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S262664AbREaBTH>; Wed, 30 May 2001 21:19:07 -0400
Message-ID: <3B159BC2.820355FD@evision-ventures.com>
Date: Thu, 31 May 2001 03:17:54 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Joel Becker <jlbec@evilplan.org>
CC: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> <9f41vq$our$1@cesium.transmeta.com> <p05100316b73b3f2e80e2@[10.128.7.49]> <20010531013827.J16761@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> 
> On Wed, May 30, 2001 at 05:24:37PM -0700, Jonathan Lundell wrote:
> > FWIW (perhaps not much in this context), the POSIX way is sysconf(_SC_CLK_TCK)
> >
> > POSIX sysconf is pretty useful for this kind of thing (not just HZ, either).
> 
>         Well, how many hundred things on Linux are available from /proc
> but not from sysconf or the like?  :-)

Those hundert things which you either don't need or which should go to
syslog
or shouldn't be sysconf and nothing else.
