Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbSKTNzX>; Wed, 20 Nov 2002 08:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266128AbSKTNzX>; Wed, 20 Nov 2002 08:55:23 -0500
Received: from ivoti.terra.com.br ([200.176.3.20]:50363 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP
	id <S266120AbSKTNzW>; Wed, 20 Nov 2002 08:55:22 -0500
Date: Wed, 20 Nov 2002 12:02:23 -0200
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
Message-ID: <20021120120223.A15034@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br> <shsy99f16np.fsf@charged.uio.no> <20021003202602.M3869@blackjesus.async.com.br> <15772.60202.510717.850059@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15772.60202.510717.850059@charged.uio.no>; from trond.myklebust@fys.uio.no on Fri, Oct 04, 2002 at 03:13:14AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 03:13:14AM +0200, Trond Myklebust wrote:
> That's more or less right, except that the communication is bidirectional.
> 
>     >> lies with rpc.statd.  Can you see any reason in your setup why
>     >> it should be failing?
> 
>      > Not really. The clients run rpc.statd 1.0 and the server,
>      > 1.0.1. Should I start gdbing it to see what is going wrong?
> 
> Start by using tcpdump to find out who, in the above chain, is taking
> such a long time to respond.

I haven't forgotten this. It's just that I've been unable to test: the
problem just stopped showing up when I upgraded to 2.4.20-pre11 with
your NFS-ALL patches applied to it. Could something have changed, or are
we just lucky?

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
