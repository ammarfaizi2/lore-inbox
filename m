Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266396AbUA2VBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 16:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUA2VBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 16:01:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:18911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266396AbUA2VBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 16:01:35 -0500
Date: Thu, 29 Jan 2004 12:56:13 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: kiza@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc2 + aha152x still oopses
Message-Id: <20040129125613.0757af61.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0401292100001.4784-100000@poirot.grange>
References: <200401281458.47217.kiza@gmx.net>
	<Pine.LNX.4.44.0401292100001.4784-100000@poirot.grange>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The aha152x maintainer (Juergen E. Fischer) has already replied:

No, that was an other bug.  Try attached patch.  I already submitted it
to Andrew Morton and expect it to appear in 2.6.2.



On Thu, 29 Jan 2004 21:06:16 +0100 (CET) Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

| I am forwarding your email to linux-scsi. Besides, there has been some
| fixes merged recently in 2.6.2-rcX, try the latest available. However, not
| sure if your specific problem has been fixed there.
| 
| Guennadi
| 
| On Wed, 28 Jan 2004, Oliver Feiler wrote:
| 
| > Hi,
| >
| > this is related to my post from Jan 7th, see
| > http://lkml.org/lkml/2004/1/6/202.
| >
| > The Oops in the aha152x driver was supposed to be fixed in 2.6.1-rc1 from what
| > I was told. I've been running 2.6.1-rc2 and indeed it didn't happen with that
| > kernel. Today however I got a slightly different oops with the same kernel. I
| > didn't see any changes to the driver since 2.6.1-rc2 so I didn't upgrade
| > (takes a long time to compile on a 486).
| >
| > I got two oopses which I attached to this mail. After that the system needed
| > to be resetted. Is this a new problem or did I just miss changes to the
| > driver and it is already fixed in 2.6.2-rc2?
| >
| > Bye,
| > Oliver
| >
| > --
| > Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>
| >
| 
| ---
| Guennadi Liakhovetski

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
