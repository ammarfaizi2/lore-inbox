Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTBXR16>; Mon, 24 Feb 2003 12:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbTBXR16>; Mon, 24 Feb 2003 12:27:58 -0500
Received: from angband.namesys.com ([212.16.7.85]:44163 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261290AbTBXR15>; Mon, 24 Feb 2003 12:27:57 -0500
Date: Mon, 24 Feb 2003 20:38:10 +0300
From: Oleg Drokin <green@namesys.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@digeo.com>, vs@namesys.com, nikita@namesys.com,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4 iget5_locked port attempt to 2.4 (supposedly fixed NFS version this time)
Message-ID: <20030224203810.A18740@namesys.com>
References: <20030220175309.A23616@namesys.com> <20030220154924.7171cbd7.akpm@digeo.com> <20030221220341.A9325@namesys.com> <20030221200440.GA23699@delft.aura.cs.cmu.edu> <20030224132145.A7399@namesys.com> <15962.19783.182617.822504@charged.uio.no> <20030224200323.A18408@namesys.com> <15962.21418.869267.676983@charged.uio.no> <20030224202619.A18641@namesys.com> <15962.22381.294644.724830@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15962.22381.294644.724830@charged.uio.no>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Feb 24, 2003 at 06:33:33PM +0100, Trond Myklebust wrote:
>      > Hello!  On Mon, Feb 24, 2003 at 06:17:30PM +0100, Trond
>      > Myklebust wrote:
>     >> >> like that keeps turning the clock backward on the server,
>     >> >> then the NFS client has no chance of recognizing which
>     >> >> attribute updates are the more recent ones.
>     >> > Ok, I stopped ntpd. Will see what will happen. ;) Aha, it
>     >> > died already: doread: read: Input/output error
>     >> Silly question: Are you perhaps testing using the 'soft' mount
>     >> option?
>      > Hm. I just mount it as mount server:/tmp /mnt -t nfs no extra
>      > options. So I guess no, I do not have wthis soft stuff.
> ...and there were no accompanying messages logged by syslog? In

None at all at both sides. (btw, I am running NFSv3)

Bye,
    Oleg
