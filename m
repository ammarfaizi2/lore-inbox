Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293681AbSCKKxO>; Mon, 11 Mar 2002 05:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293687AbSCKKxG>; Mon, 11 Mar 2002 05:53:06 -0500
Received: from angband.namesys.com ([212.16.7.85]:3200 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S293682AbSCKKw6>; Mon, 11 Mar 2002 05:52:58 -0500
Date: Mon, 11 Mar 2002 13:52:56 +0300
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-ID: <20020311135256.A856@namesys.com>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no> <200203110018.BAA11921@webserver.ithnet.com> <15499.64058.442959.241470@charged.uio.no> <20020311091458.A24600@namesys.com> <20020311114654.2901890f.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311114654.2901890f.skraw@ithnet.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Mar 11, 2002 at 11:46:54AM +0100, Stephan von Krawczynski wrote:
> <4>reiserfs: checking transaction log (device 22:01) ...
> <4>Using tea hash to sort names
> <4>reiserfs: using 3.5.x disk format

This means you have reiserfs v3.5 format on /dev/hdc1
And this one won't behave very good with nfs.
Does this one contain your nfs exports?

Bye,
    Oleg
