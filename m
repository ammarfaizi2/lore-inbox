Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293739AbSCKNwN>; Mon, 11 Mar 2002 08:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293757AbSCKNvy>; Mon, 11 Mar 2002 08:51:54 -0500
Received: from angband.namesys.com ([212.16.7.85]:41856 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S310123AbSCKNvl>; Mon, 11 Mar 2002 08:51:41 -0500
Date: Mon, 11 Mar 2002 16:51:40 +0300
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-ID: <20020311165140.A1839@namesys.com>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no> <200203110018.BAA11921@webserver.ithnet.com> <15499.64058.442959.241470@charged.uio.no> <20020311091458.A24600@namesys.com> <20020311114654.2901890f.skraw@ithnet.com> <20020311135256.A856@namesys.com> <20020311155937.A1474@namesys.com> <20020311154852.3981c188.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311154852.3981c188.skraw@ithnet.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Mar 11, 2002 at 03:48:52PM +0100, Stephan von Krawczynski wrote:
> > Just to be sure - have you tried 2.4.17 at the server?
> I just checked with 2.4.17 on the server side: the problem stays.
> I guess it will not make any sense to try your patches (reversing).

Yes.
Hm. Can you make non-reiserfs partition (say ext2) and try to reproduce a
problem on it. This way we can know which direction to dig further.

Trod, do you think that'll work or should some other non-ext2 fs be tried?

Bye,
    Oleg
