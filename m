Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130955AbRAaIqx>; Wed, 31 Jan 2001 03:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131388AbRAaIqn>; Wed, 31 Jan 2001 03:46:43 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:56290 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S130955AbRAaIqc>;
	Wed, 31 Jan 2001 03:46:32 -0500
Message-Id: <m14NsuB-000OZJC@amadeus.home.nl>
Date: Wed, 31 Jan 2001 09:46:19 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: kaos@ocs.com.au (Keith Owens)
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 -- Unresolved symbols in radio-miropcm20.o
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <3A772D3C.CB62DD4F@megapath.net> <4987.980895146@ocs3.ocs-net>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4987.980895146@ocs3.ocs-net> you wrote:
> Also the config.in files need
> fixing for these files, it is possible to select combinations of aci
> and miropcm20 that will fail to link (miropcm20 built in, aci not
> selected or selected as a module) or fail to load (miropcm20 selected
> as a module, aci not selected).

Unfortionatly, this is impossible. The miropcm config question is asked
before the "sound" question, and the aci question is asked after that (all
in ake config). In 2.2.x we have an #ifdef in the driver that causes an
#error with a description of the problem and the solution. Someone stripped
that #ifdef out of the driver during 2.3.something.

Greetings,
   Arjan van de Ven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
