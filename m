Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSBDSMI>; Mon, 4 Feb 2002 13:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284138AbSBDSL7>; Mon, 4 Feb 2002 13:11:59 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:40884 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S274862AbSBDSLw>;
	Mon, 4 Feb 2002 13:11:52 -0500
Date: Mon, 4 Feb 2002 19:11:50 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Generic HDLC patch for 2.5.3
Message-ID: <20020204191150.A11131@fafner.intra.cogenit.fr>
In-Reply-To: <20020202190242.C1740@havoc.gtf.org> <E16XAnc-00010K-00@the-village.bc.nu> <20020202200332.A3740@havoc.gtf.org> <20020203181302.C12963@fafner.intra.cogenit.fr> <20020203124614.A10139@havoc.gtf.org> <20020203230652.D12963@fafner.intra.cogenit.fr> <m3g04h5rpn.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3g04h5rpn.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Mon, Feb 04, 2002 at 01:58:28PM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> :
> Francois Romieu <romieu@cogenit.fr> writes:
[...]
> > +typedef struct {
> > +	unsigned short encoding;
> > +	unsigned short parity;
> > +} raw_proto;
> 
> This isn't for "raw" protocol. It's for raw _HDLC_ (or "just" HDLC),
> so I think a better name is still hdlc_proto.

hdlc with address and command unspecified looks "raw" to me.
-> raw_hdlc ?
 
-- 
Ueimor
