Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293735AbSCKNrd>; Mon, 11 Mar 2002 08:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310112AbSCKNr0>; Mon, 11 Mar 2002 08:47:26 -0500
Received: from ns.ithnet.com ([217.64.64.10]:62729 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S293735AbSCKNrS>;
	Mon, 11 Mar 2002 08:47:18 -0500
Date: Mon, 11 Mar 2002 15:48:52 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020311154852.3981c188.skraw@ithnet.com>
In-Reply-To: <20020311155937.A1474@namesys.com>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
	<200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com>
	<20020311155937.A1474@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002 15:59:37 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Mon, Mar 11, 2002 at 01:47:17PM +0100, Stephan von Krawczynski wrote:
> > What else can I try?
> > I checked the setup with another client kernel 2.4.18, and guess what: it has
> > the same problem. I have the impression that the problem is somewhere on the
> > nfs server side - possibly around the umount case. Trond, Ken?
> Just to be sure - have you tried 2.4.17 at the server?

Hello Oleg,

I just checked with 2.4.17 on the server side: the problem stays.
I guess it will not make any sense to try your patches (reversing).

Regards,
Stephan

