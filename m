Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265783AbRFXW5E>; Sun, 24 Jun 2001 18:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265784AbRFXW4y>; Sun, 24 Jun 2001 18:56:54 -0400
Received: from iq.sch.bme.hu ([152.66.214.168]:37837 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S265783AbRFXW4s>;
	Sun, 24 Jun 2001 18:56:48 -0400
Date: Mon, 25 Jun 2001 01:08:01 +0200 (CEST)
From: Sasi Peter <sape@iq.rulez.org>
To: "J . A . Magallon" <jamagallon@able.es>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OT] gcc 2.95.2 vs. 3.0 (fwd)
In-Reply-To: <20010625004822.C1799@werewolf.able.es>
Message-ID: <Pine.LNX.4.33.0106250059000.27257-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001, J . A . Magallon wrote:

> Sure it is opendivx ? I think you are just using gcc compiled code for
> the 'interface' and 'glue' to windows divx decoders (/usr/lib/win32/*.dll)
> that do the real hard work.

Have a look at mplayer.sourceforge.net. MPlayer besides DLL loading also
features native Opendivx en/decoding, and native MPEG1/2 decoding.
Actually the tests were performed by the leader of the development of
mplayer, and he did compile the whole opendivx encore/decore code used in
this player, taken from the original sources.

> Redo the tests with am MPEG2 movie.

Actually since the original posting, on the mplayer-devel list the
maintainer of mpeg2play (the portable parts of mplayer as a separate
player, w/o the dll stuff) also tested how well MPEG1/2 decoding works if
compiled w/ gcc 2.95.2 vs 3.0, and he was disappointed too, because there
was a slight decrease in the performanceof the generated code...

If you want proof of these, grab the C sources from the mentioned
sourceforge project site, and repeat the test yourself.

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/

