Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266597AbRGFMeu>; Fri, 6 Jul 2001 08:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbRGFMek>; Fri, 6 Jul 2001 08:34:40 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:702 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S266597AbRGFMe0>;
	Fri, 6 Jul 2001 08:34:26 -0400
Message-ID: <3B45B04A.9A85ECA0@mandrakesoft.com>
Date: Fri, 06 Jul 2001 08:34:18 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Juergen Wolf <JuWo@N-Club.de>
Cc: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
In-Reply-To: <Pine.LNX.4.30.0107021014230.15054-100000@flash.datafoundation.com> <3B42DEC2.AAB1E65B@N-Club.de> <20010704145752.A29311@se1.cogenit.fr> <3B456D45.FBF10C1A@N-Club.de> <20010706134421.B20614@se1.cogenit.fr> <3B45AEBD.8D0599E3@N-Club.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Wolf wrote:
> 
> Francois Romieu wrote:
> >
> > Could you try 2.4.6 with just this modification: ?
> >
> 
> hm, looks like thats really the point. After applying your diff file
> everything works fine.

Does it work with this line?

outl(0x12, ioaddr + MIICfg);

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
