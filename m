Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313014AbSD3QaN>; Tue, 30 Apr 2002 12:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSD3QaN>; Tue, 30 Apr 2002 12:30:13 -0400
Received: from erasmus.off.net ([64.39.30.25]:30227 "EHLO erasmus.off.net")
	by vger.kernel.org with ESMTP id <S313014AbSD3QaM>;
	Tue, 30 Apr 2002 12:30:12 -0400
Date: Tue, 30 Apr 2002 12:30:13 -0400
From: Zach Brown <zab@zabbo.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Wanghong Yuan <wyuan1@ews.uiuc.edu>, linux-kernel@vger.kernel.org
Subject: Re: Accurately measure CPU cycles used by a program? thanks
Message-ID: <20020430123013.E30752@erasmus.off.net>
In-Reply-To: <20020428.204911.63038910.davem@redhat.com> <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu> <005d01c1efcb$561b8c10$e6f7ae80@ad.uiuc.edu> <20020429222243.GC1732@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Is there any package or program, which can be used to accurately measure the
> >CPU cycles used by a program? I think the following code can only provide an
> 
> man getrusage

There is a measurable chance that getrusage isn't good enough, something
like perfctr ( http://www.csd.uu.se/~mikpe/linux/perfctr/ ) that
actually measures cpu events may be more insteresting.  See also:
http://oprofile.sourceforge.net/

- z
