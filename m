Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262672AbRE3Jaw>; Wed, 30 May 2001 05:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262674AbRE3Jam>; Wed, 30 May 2001 05:30:42 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:9103 "EHLO sunrise.pg.gda.pl")
	by vger.kernel.org with ESMTP id <S262672AbRE3Jae>;
	Wed, 30 May 2001 05:30:34 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200105300929.LAA02627@sunrise.pg.gda.pl>
Subject: Re: Generating valid random .configs
To: arjanv@redhat.com
Date: Wed, 30 May 2001 11:29:42 +0200 (MET DST)
Cc: anuradha@gnu.org, linux-kernel@vger.kernel.org
In-Reply-To: <3B14AEFC.B522A7B4@redhat.com> from "Arjan van de Ven" at May 30, 2001 09:27:40 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Arjan van de Ven wrote:"
> Anuradha Ratnaweera wrote:
> > 
> > Recently, I posted a request here to send your .config files and I
> > received a good number of them. (thanks!).
> > 
> > Now I want to generate even more different configurations, and a random
> > .config generator would be ideal. If I write a program which randomly
> > outputs "y", "m" and "n" and pipe its output through make config, will the
> > generated .configs always compile? Yes. the best thing is to go ahead and
> > try it (which I am doing at the moment) but I like to know the theoretical
> > answer;)
> 
> Every once in a while I run this and fix everything that doesn't
> compile. It has been 
> 2 months since I last did that, so I should do it again soon..

Some things cannot be properly fixed in CML1.
  "$CONFIG_BINFMT_MISC" = "y" -a "$CONFIG_PROC_FS" = "n"
is a good example.

Andrzej

