Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293699AbSCKLZY>; Mon, 11 Mar 2002 06:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293703AbSCKLZO>; Mon, 11 Mar 2002 06:25:14 -0500
Received: from ns.ithnet.com ([217.64.64.10]:522 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S293699AbSCKLZE>;
	Mon, 11 Mar 2002 06:25:04 -0500
Date: Mon, 11 Mar 2002 12:24:56 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020311122456.6dca1c61.skraw@ithnet.com>
In-Reply-To: <20020311141154.C856@namesys.com>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
	<200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com>
	<20020311141154.C856@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002 14:11:54 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> [...]
> > There is _no_ /dev/hdc1.
> 
> Stupid me! Numbers are in hex! ;)

aahh, shoot me, a lot of trees, but no forest in sight ... ;-)

> So that's /dev/hdg1 that is reiserfs v3.5
> 
> > /dev/hdg1             20043416  16419444   3623972  82% /p3
> > Exported fs is on /dev/hde1.
> 
> Hm. Strange. Are you sure you do not export /dev/hdg1?

Yes, you are right here, one of the exports comes from hdg1. I will reformat with 3.6 and re-check the problem. Anyways I find it interesting that the problem does not occur with 2.2.19 client side ...

Stay tuned, I'll be back.

Regards,
Stephan

