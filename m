Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293201AbSCKGPN>; Mon, 11 Mar 2002 01:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293167AbSCKGPD>; Mon, 11 Mar 2002 01:15:03 -0500
Received: from angband.namesys.com ([212.16.7.85]:55438 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S293081AbSCKGO7>; Mon, 11 Mar 2002 01:14:59 -0500
Date: Mon, 11 Mar 2002 09:14:58 +0300
From: Oleg Drokin <green@namesys.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-ID: <20020311091458.A24600@namesys.com>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no> <200203110018.BAA11921@webserver.ithnet.com> <15499.64058.442959.241470@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15499.64058.442959.241470@charged.uio.no>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Mar 11, 2002 at 01:28:42AM +0100, Trond Myklebust wrote:
>      > this is a weak try of an explanation. All involved fs types are
>      > reiserfs. The problem occurs reproducably only after (and
> Which ReiserFS format? Is it version 3.5?

>    'cat /proc/fs/reiserfs/device/version'

If this does not work because you have no such file, then look through your
kernel logs, if you use reiserfs v3.5 on 2.4 kernel, it will show itself
as such record in the log file: "reiserfs: using 3.5.x disk format"

Bye,
    Oleg
