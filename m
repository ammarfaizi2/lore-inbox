Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132695AbRC2J2S>; Thu, 29 Mar 2001 04:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132694AbRC2J2I>; Thu, 29 Mar 2001 04:28:08 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:25093 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S132688AbRC2J2B>;
	Thu, 29 Mar 2001 04:28:01 -0500
Date: Thu, 29 Mar 2001 11:25:47 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: configuring net interfaces
Message-ID: <20010329112547.A23947@se1.cogenit.fr>
In-Reply-To: <m3itkuq6xt.fsf@intrepid.pm.waw.pl> <20010328182729.A16067@se1.cogenit.fr> <m34rwd8pj2.fsf@intrepid.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <m34rwd8pj2.fsf@intrepid.pm.waw.pl>; from khc@intrepid.pm.waw.pl on Thu, Mar 29, 2001 at 01:03:29AM +0200
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@intrepid.pm.waw.pl> écrit :
[...]
> That's a physical interface like V.35 or RS232.

Ok.

[...]
> > * n200, t200 ?
> 
> What's that?

Parameters for retransmission of a trame specified in Q922. t200 is the
timeout value and n200 the maximal number of retransmissions. They can
be negocied and default to t200=1,5s, n200=3.

> > Do we put the crc type here ?
> 
> I don't think so. Frame Relay uses only standard CRC. Correct me if I'm
> wrong.

Ok.

[...]
> > While we're here, could we agree on the notion of raw hdlc, i.e. :
> > - no address, no command. crc present (ARPHRD_RAWHDLC ?);
> > - no address, no command, no crc (ARPHRD_PATHOLOGICHDLC ?).
> 
> Do we really need another ARPHRD for that?
> BTW: What protocol(s) use such CRC-less HDLC?

No protocol I know. Sometime one just want to verify how a driver performs
when he receives badly fscked data. One can live without it.

-- 
Ueimor
