Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSLBOoD>; Mon, 2 Dec 2002 09:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbSLBOoC>; Mon, 2 Dec 2002 09:44:02 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:34742 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S264706AbSLBOoC>; Mon, 2 Dec 2002 09:44:02 -0500
Date: Mon, 2 Dec 2002 12:51:16 -0200
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>, NFS@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
Message-ID: <20021202125116.T22501@blackjesus.async.com.br>
References: <shsy99f16np.fsf@charged.uio.no> <20021003202602.M3869@blackjesus.async.com.br> <15772.60202.510717.850059@charged.uio.no> <20021120120223.A15034@blackjesus.async.com.br> <15835.49194.109931.227732@charged.uio.no> <20021126224123.A9660@blackjesus.async.com.br> <15844.7306.735524.133781@charged.uio.no> <20021127150828.A12120@blackjesus.async.com.br> <15845.11182.384531.599421@charged.uio.no> <20021128233412.A18448@blackjesus.async.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021128233412.A18448@blackjesus.async.com.br>; from kiko@async.com.br on Thu, Nov 28, 2002 at 11:34:12PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 11:34:12PM -0200, Christian Reis wrote:
> On Wed, Nov 27, 2002 at 09:31:42PM +0100, Trond Myklebust wrote:
> > >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> > 
> >      > What can I do to help further debug the issue? Try another
> >      > kernel version on clients? Server? This is giving me a
> >      > headache.. :-/
> > 
> > Try to give us a dump of the server lock manager activity when this
> > problem occurs. Try to do
> > 
> > echo "217" >/proc/sys/sunrpc/nlm_debug
> 
> Okay, I've just done that. Just completing information, this server uses
> ReiserFS filesystems, and I know we've had issues with knfsd and reiser
> before, so I guess it's at least relevant to say. 

Trond, did you have a minute to look at this? I wonder if it's really
related to Reiser or not..

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
