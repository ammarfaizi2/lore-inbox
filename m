Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135410AbRAGDne>; Sat, 6 Jan 2001 22:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135420AbRAGDnO>; Sat, 6 Jan 2001 22:43:14 -0500
Received: from Cantor.suse.de ([194.112.123.193]:32520 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135410AbRAGDnH>;
	Sat, 6 Jan 2001 22:43:07 -0500
Date: Sun, 7 Jan 2001 04:43:04 +0100
From: Andi Kleen <ak@suse.de>
To: Jean-Christian de Rivaz <jcdr@lightning.ch>
Cc: jpranevich@lycos.com, linux-kernel@vger.kernel.org
Subject: Re: New features in Linux 2.4 - Wonderful World of Linux 2.4
Message-ID: <20010107044304.B14330@gruyere.muc.suse.de>
In-Reply-To: <CNDCNNNONGMAFAAA@mailcity.com> <3A5782EF.93297FC5@lightning.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5782EF.93297FC5@lightning.ch>; from jcdr@lightning.ch on Sat, Jan 06, 2001 at 09:41:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 09:41:19PM +0100, Jean-Christian de Rivaz wrote:
> Joe Pranevich wrote:
> >
> > Networking and Protocols
> >
> >                                     ... It should also be mentioned at
> >    this point that Linux is still the only operating system completely
> >    compatible with the letter of the IPv4 specification ...
> 
> I am very interesting about the proof of this. I work on a project witch
> need to be certified. Any informations about the compliance of Linux to
> some specification is very welcome.

It's very dubious at least. AFAIK no RFC1122/RFC1812 evulation has been done recently
(since 2.0 or so). Also part of these RFCs have been superseeded by later RFCs
that have not reached Internet standard status yet, so it would not be very useful
anyways (today's internet looks very different from 1989's when 1122 was written) 

The mechanism the comment refers to (asynchronous error notification for UDP, which
is not in traditional BSD) is not used by 99.9% of all apps BTW ;) 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
