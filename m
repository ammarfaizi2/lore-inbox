Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318542AbSGaW6w>; Wed, 31 Jul 2002 18:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318546AbSGaW6w>; Wed, 31 Jul 2002 18:58:52 -0400
Received: from ns.suse.de ([213.95.15.193]:36359 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318542AbSGaW6v>;
	Wed, 31 Jul 2002 18:58:51 -0400
Date: Thu, 1 Aug 2002 01:02:17 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.29: some compilation fixes for irq frenzy [OSS + i8x0 audio]
Message-ID: <20020801010217.K10436@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andy Pfiffer <andyp@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1028062608.964.6.camel@andyp> <1028067951.8510.44.camel@irongate.swansea.linux.org.uk> <1028063953.964.13.camel@andyp> <1028069255.8510.46.camel@irongate.swansea.linux.org.uk> <1028152202.964.84.camel@andyp> <1028160492.13008.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1028160492.13008.7.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 01, 2002 at 01:08:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 01:08:12AM +0100, Alan Cox wrote:
 > Rusty submitted a much better patch for this - deleting all the old OSS
 > ISA drivers, so that people can just fix and use the ALSA code instead.
 > I'm not saying don't analyse the locks and interrupt paths and fix the
 > OSS audio for ISA stuff, just that it might not be the best use of time
 > even if you do get it sorted out.

Are there any OSS drivers for any particular cards for which we don't have
an equivalent ALSA driver ?  If we're ultimately going to be dropping
any of the OSS drivers, I'd rather know about it so I don't waste time
pushing the ~200kb of patches in that area I'm currently carrying
towards Linus.  (Given that most of them don't compile right now due to
the collateral damage from the cli() etc changes , I'd *love* to take
the lazy^Weasy option and just drop them)

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
