Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318487AbSHVIaq>; Thu, 22 Aug 2002 04:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318538AbSHVIaq>; Thu, 22 Aug 2002 04:30:46 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:13222 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S318487AbSHVIaq>; Thu, 22 Aug 2002 04:30:46 -0400
Subject: Re: ServerWorks OSB4 in impossible state
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Gonzalo Servat <gonzalo@unixpac.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1030002761.32380.27.camel@pluto.unixpac.com.au>
References: <1030002761.32380.27.camel@pluto.unixpac.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Aug 2002 10:35:16 +0200
Message-Id: <1030005316.9869.52.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2002-08-22 um 09.52 schrieb Gonzalo Servat:

> Do you have any suggestions on how I can work around this problem? It's
> been driving me nuts all day! (I bet it's driven people nuts for
> weeks...). Do you think your patch (as posted on
> http://linux-kernel.skylab.org/20020609/msg00935.html) may help my
> situation? If so, what kernel does it apply to? I looked up
> serverworks.c in a 2.4.19-rc3 tree to see if the patch would apply
> cleanly but it won't because line 547 is different to yours.

It should be fairly easy to adapt the patch, all you need is modify 
the line
			if(inb(dma_base+0x02)&1)

in svwks_dmaproc() to the more complex condition test in the patch.

Alan, I understood you to wanted apply this patch - what happened to it,
do you want me to resubmit it?

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





