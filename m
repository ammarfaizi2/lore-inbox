Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318503AbSICSsY>; Tue, 3 Sep 2002 14:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSICSsY>; Tue, 3 Sep 2002 14:48:24 -0400
Received: from gate.in-addr.de ([212.8.193.158]:4877 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S318503AbSICSsX>;
	Tue, 3 Sep 2002 14:48:23 -0400
Date: Tue, 3 Sep 2002 20:53:44 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>, root@chaos.analogic.com
Cc: Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
Message-ID: <20020903185344.GA7836@marowsky-bree.de>
References: <Pine.LNX.3.95.1020903115445.1058A-100000@chaos.analogic.com> <200209031629.g83GT2e08075@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200209031629.g83GT2e08075@oboe.it.uc3m.es>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-03T18:29:02,
   "Peter T. Breuer" <ptb@it.uc3m.es> said:

> > Lets say you have a perfect locking mechanism, a fake SCSI layer
> OK.

BTW, I would like to see your perfect distributed locking mechanism.


> The directory entry would ceryainly have to be reread after a write
> operation on disk that touched it - or more simply, the directory entry
> would hvae to be reread every time it were needed, i.e. be uncached.

*ouch* Sure. Right. You just have to read it from scratch every time. How
would you make readdir work?

> If that presently is not possible, then I would like to think about
> making it possible.

Just please, tell us why.



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

