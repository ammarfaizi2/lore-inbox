Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135809AbRECRec>; Thu, 3 May 2001 13:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135830AbRECReW>; Thu, 3 May 2001 13:34:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65031 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135809AbRECReL>; Thu, 3 May 2001 13:34:11 -0400
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, aka ...]
To: esr@thyrsus.com
Date: Thu, 3 May 2001 18:36:55 +0100 (BST)
Cc: vonbrand@inf.utfsm.cl (Horst von Brand), stoffel@casc.com (John Stoffel),
        cate@dplanet.ch, linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503120416.H31960@thyrsus.com> from "Eric S. Raymond" at May 03, 2001 12:04:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vN29-0005sT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Horst von Brand <vonbrand@inf.utfsm.cl>:
> > If you support broken configurations in any way, your program is just
> > wildly guessing what they did mean. The exact (and very probably not in any
> > way cleanly thought out) behaviour in corner cases then becomes "the way
> > things work", and we end up in an unmaintainable mess yet again.
> 
> Yes, this is precisely what I fear.

I have been thinking about this in more detail. In a sense oldconfig does do
stuff you dont see and can cause suprises but its better than 'fix it yourself
tough' which is the other approach.

If that aspect of it worries you collect a list of the symbols that were 
changed by the oldconfig process and colour them differently and/or offer
a view of them as part of the navigation

