Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUIKRAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUIKRAi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUIKRAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:00:38 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:26555 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268210AbUIKRAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:00:33 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
Date: Sat, 11 Sep 2004 18:02:45 +0200
User-Agent: KMail/1.6.2
Cc: tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
       Linux-IDE <linux-ide@vger.kernel.org>
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de> <200409102321.17042.bzolnier@elka.pw.edu.pl> <4142D3AE.5050602@inet6.fr>
In-Reply-To: <4142D3AE.5050602@inet6.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409111802.45628.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 September 2004 12:30, Lionel Bouton wrote:
> Bartlomiej Zolnierkiewicz wrote the following on 09/10/2004 11:21 PM :
> 
> >>I see it's not really a cutting-edge design (2002). Apparently nobody 
> >>seemed to care about Linux IDE performance before :-|
> >>    
> >>
> >
> >Yep. :/  Lionel, can I push this fix upstream?
> >  
> >
> 
> Please do.

OK, will do.

> In fact I think I'm only a speed bumper here. There's so little work to 
> do on the sis5513 driver now that I don't follow IDE work closely 
> anymore and must refresh my memories even for such simple patches. I 
> believe there are people around more fit than me for sis5513 maintenance.

I'm not aware of any such person...

> With SATA, sis5513.c will soon be considered legacy code. I don't think 
> a dedicated maintainer is usefull anymore, seems to me it would be 
> better handled by someone with a broader view of IDE chipsets than me.

Dedicated maintainers are very useful even for legacy drivers.
This way the subsystem maintainer doesn't have to worry about
every fscking driver (less bugs, faster development). :-)

If you really want to give up maintainership of sis5513 please
send a patch to Linus+me removing you from MAINTAINERS file.

Anyway, thanks for all your hard work on sis5513 driver.
