Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272429AbSISTNT>; Thu, 19 Sep 2002 15:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272449AbSISTNT>; Thu, 19 Sep 2002 15:13:19 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:21444 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S272429AbSISTNS>;
	Thu, 19 Sep 2002 15:13:18 -0400
Date: Thu, 19 Sep 2002 21:17:38 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, henrique@cyclades.com
Subject: Re: 2.4 + generic HDLC update? Any ideas?
Message-ID: <20020919211738.A12722@fafner.intra.cogenit.fr>
References: <m3r8fqm7ez.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3r8fqm7ez.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Thu, Sep 19, 2002 at 03:32:36PM +0200
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> :
[...]
> - the other driver affected is DSCC4, but I know exactly nothing about
>   it (a 2.5 version of it is, of course, available). What do you think,
>   Francois?

dscc4 maintainer:
I use a code marrying the core 2.4.x dscc4 with a 2.5.x hdlc to test 2.5.x
dscc4. Thus no real extra load. Hdlc glue in current 2.4.x dscc4 does its 
job but I wouldn't recommend it as a model for the newer generation.

dscc4 users:
Migration from specific scctool.c + sethdlc to single sethdlc. Definitely
a simpler life.

If users damn me, I'll surely meet someone from Infineon in hell to discuss
dscc4 :o)

vendors:
- dscc4 not included in rh 2.4 last time I looked at it (I labelled it
  'EXPERIMENTAL');
- 2.4.18 mdk kills it using Krzysztof's post-2.4-didn't-make-2.5 (!) hdlc;
- don't know what the others do.

Imho dscc4 doesn't need to be taken too much in consideration regarding
2.4.x hdlc stack change.

-- 
Ueimor
