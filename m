Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319117AbSH2FlP>; Thu, 29 Aug 2002 01:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319118AbSH2FlP>; Thu, 29 Aug 2002 01:41:15 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:22789 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319117AbSH2FlO>;
	Thu, 29 Aug 2002 01:41:14 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208290545.g7T5jUE07536@oboe.it.uc3m.es>
Subject: Re: block device/VM question
To: thunder@lightweight.ods.org
Date: Thu, 29 Aug 2002 07:45:30 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago ptb wrote:"
> "A month of sundays ago ptb wrote:"
> > "A month of sundays ago Thunder from the hill wrote:"
> > > > And for the O_DIRECT flag we seem to do alloc_kiovec(1, &f->f_iobuf).
> > > 
> > > Perhaps we should go biovec here?

I've now tried opening the ram disk device O_DIRECT in 2.4.19. Same result
as on my driver: every write returns EINVAL.

How does one use O_DIRECT? It needs driver support?

Peter
