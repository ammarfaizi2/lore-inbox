Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312411AbSC3UlG>; Sat, 30 Mar 2002 15:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312362AbSC3Uk4>; Sat, 30 Mar 2002 15:40:56 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:47365 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S312411AbSC3Uko>; Sat, 30 Mar 2002 15:40:44 -0500
Date: Sat, 30 Mar 2002 13:40:17 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre5
Message-ID: <20020330134017.A14523@mail.harddata.com>
In-Reply-To: <Pine.LNX.4.21.0203291842530.6417-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 29, 2002 at 06:47:39PM -0300, Marcelo Tosatti wrote:
> 
> Here goes pre5.

Tried to recompile that on Alpha and I run into module symbol
troubles of that sort:

depmod: /lib/modules/2.4.19-pre5/kernel/drivers/sound/trident.o: Bad symbol index: 20414130 >= 000000d6
depmod: /lib/modules/2.4.19-pre5/kernel/drivers/sound/trident.o: Bad symbol index: 74202a2f >= 000000d6
depmod: /lib/modules/2.4.19-pre5/kernel/drivers/sound/trident.o: Bad symbol index: 0a2f2a20 >= 000000d6
depmod: Bad symbol index: 20414130 >= 000000d6
depmod: Bad symbol index: 74202a2f >= 000000d6
depmod: Bad symbol index: 0a2f2a20 >= 000000d6

Any ideas where these are coming from?  Nothing of that sort cropped out
in 2.4.19-pre4.  modutils are 2.4.13 which should be good enough if one
believes in Documentation/Changes.

As I am not really using 'trident' module right now this was not a
big obstacle to boot and run that kernel. :-)

  Michal

