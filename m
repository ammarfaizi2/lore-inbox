Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311203AbSCaBla>; Sat, 30 Mar 2002 20:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311206AbSCaBlV>; Sat, 30 Mar 2002 20:41:21 -0500
Received: from harddata.com ([216.123.194.198]:51461 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S311203AbSCaBlM>;
	Sat, 30 Mar 2002 20:41:12 -0500
Date: Sat, 30 Mar 2002 18:41:01 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre5
Message-ID: <20020330184101.A16046@mail.harddata.com>
In-Reply-To: <20020330134017.A14523@mail.harddata.com> <11078.1017531282@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2002 at 09:34:42AM +1000, Keith Owens wrote:
> On Sat, 30 Mar 2002 13:40:17 -0700, 
> Michal Jaegermann <michal@harddata.com> wrote:
> >
> >On Fri, Mar 29, 2002 at 06:47:39PM -0300, Marcelo Tosatti wrote:
> >> 
> >> Here goes pre5.
> >
> >Tried to recompile that on Alpha and I run into module symbol
> >troubles of that sort:
> >
> >depmod: /lib/modules/2.4.19-pre5/kernel/drivers/sound/trident.o: Bad symbol index: 20414130 >= 000000d6
> >depmod: /lib/modules/2.4.19-pre5/kernel/drivers/sound/trident.o: Bad symbol index: 74202a2f >= 000000d6
> >depmod: /lib/modules/2.4.19-pre5/kernel/drivers/sound/trident.o: Bad symbol index: 0a2f2a20 >= 000000d6
> >depmod: Bad symbol index: 20414130 >= 000000d6
> >depmod: Bad symbol index: 74202a2f >= 000000d6
> >depmod: Bad symbol index: 0a2f2a20 >= 000000d6
> 
> That is almost always caused by bad output from binutils.

Thanks to the helpful comment from Keith the matter is resolved.  The
box in which this happened still has "issues" and apparently decided
that it is time for one of its surprises.  That trident.o module
recreated from scratch looks ok.

  Thanks,
  Michal
