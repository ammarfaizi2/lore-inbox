Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270520AbTGXIfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 04:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270524AbTGXIfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 04:35:24 -0400
Received: from fep04.swip.net ([130.244.199.132]:39898 "EHLO
	fep04-svc.swip.net") by vger.kernel.org with ESMTP id S270520AbTGXIfT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 04:35:19 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Martin Zwickel <martin.zwickel@technotrend.de>
Subject: Re: passing my own compiler options into linux kernel compiling
Date: Thu, 24 Jul 2003 10:50:25 +0200
User-Agent: KMail/1.5.2
References: <200307240916.17530.cijoml@volny.cz> <20030724100111.343d84cd.martin.zwickel@technotrend.de>
In-Reply-To: <20030724100111.343d84cd.martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307241050.25094.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

-O4 is a feature - for example MPlayer (www.mplayerhq.hu) using it.

Is easyer way of passing these args planned? Editing source every time I 
change kernel is not goood way. make oldconfig adding these args is better 
way.

Michal

Dne èt 24. èervence 2003 10:01 jste napsal(a):
> On Thu, 24 Jul 2003 09:16:17 +0200
>
> Michal Semler <cijoml@volny.cz> bubbled:
> > Hello,
> >
> > I use gcc-3.3 and I would like compile my kernel with flags:
> >
> > -O4 -march=pentium3 -mcpu=pentium3
>
> -O4 is useless. max is -O3
>
> try this file: arch/i386/Makefile
> there is something like:
>
> ifdef CONFIG_MPENTIUMIII
> CFLAGS += -march=i686
> endif
>
> maybe this helps...
>
> Regards,
> Martin

