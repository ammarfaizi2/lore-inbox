Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbSJNObU>; Mon, 14 Oct 2002 10:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261677AbSJNObU>; Mon, 14 Oct 2002 10:31:20 -0400
Received: from ns.ithnet.com ([217.64.64.10]:4109 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261659AbSJNObT>;
	Mon, 14 Oct 2002 10:31:19 -0400
Date: Mon, 14 Oct 2002 16:36:51 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: nfs-server slowdown in 2.4.20-pre10 with client 2.2.19
Message-Id: <20021014163651.6277986c.skraw@ithnet.com>
In-Reply-To: <15786.15416.668502.225074@notabene.cse.unsw.edu.au>
References: <20021013172138.0e394d96.skraw@ithnet.com>
	<15785.64463.490494.526616@notabene.cse.unsw.edu.au>
	<20021014045410.4721c209.skraw@ithnet.com>
	<15786.15416.668502.225074@notabene.cse.unsw.edu.au>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002 13:38:32 +1000
Neil Brown <neilb@cse.unsw.edu.au> wrote:

> > > Can you try going back to -pre9 and confirm that performance comes
> > > back?
> > 
> > I will have a second try on the issue this night and be back with
> > info tommorrow.
> 
> Thanks.  hopefully that will shed some light.

Hello Neil,
hello Trond,

my second try shows all the same result. The exact same setup as yesterday
night and a second try results again in very low performance. To name it:
about 11 GB of data took an incredible 13,5 hours to write to the server over a
100 MBit FDX switch.
This night I will try to reduce rsize/wsize from the current 8192 down to 1024
as suggested by Jeff.

-- 
Regards,
Stephan
