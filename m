Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSFESXO>; Wed, 5 Jun 2002 14:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315883AbSFESWF>; Wed, 5 Jun 2002 14:22:05 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:25608 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S315856AbSFESUc>; Wed, 5 Jun 2002 14:20:32 -0400
Message-ID: <3CFE567F.6B69E73B@opersys.com>
Date: Wed, 05 Jun 2002 14:20:47 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Oliver Xymoron <oxymoron@waste.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <E17FQPj-0001Rr-00@starship> <Pine.LNX.4.44.0206042132450.2614-100000@waste.org> <20020605114149.R681@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Ingo,

Ingo Oeser wrote:
> Adeos -> Client: Use virtual interrupt vectors and use your ipipe
>    for it.
> 
> Client -> Adeos: Provide Emission of this virtual interrupts in
> Adeos.
> 
> Also some kind of shared memory and a "commit" for this memory is
> needed in Adeos. Allocation of this memory should be up to the
> requester of this memory, so Adeos doesn't need to wait for it
> and neither does the RTOS on the other end.
> 
> With that primitives (plus some atomic magic ;-)) you can build
> non-sleeping messaging.
> 
> Karim, is sth. like this planned or is it senseless?

All this looks like classic nanokernel capabilities, so this is
definitely within Adeos' reach. SPACE, for instance, defines an
abstraction called "Portals" which are used for cross-domain
communication and can be implemented using exceptions (in the
SPACE papers exception == interrupt).

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
