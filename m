Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288144AbSAHPse>; Tue, 8 Jan 2002 10:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288155AbSAHPsX>; Tue, 8 Jan 2002 10:48:23 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:63777 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288144AbSAHPsS>; Tue, 8 Jan 2002 10:48:18 -0500
Date: Tue, 8 Jan 2002 16:47:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, Shirish Kalele <kalele@veritas.com>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: knfsd over TCP (was RE: 2.4.18pre2aa1)
Message-ID: <20020108164730.G1894@inspiron.school.suse.de>
In-Reply-To: <20020108155553.A1894@inspiron.school.suse.de> <shs7kqsu9zi.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <shs7kqsu9zi.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Jan 08, 2002 at 04:40:33PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 04:40:33PM +0100, Trond Myklebust wrote:
> >>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:
> 
> 
>      > 	NFS updates from Trond Myklebust. BTW, the svc tcp patches are
>      > 	broken, they oopsed on me with a simple mount of nfs via udp,
>      > 	so I left them out. this is the oops for the record:
> 
> Duh...
> 
> sunrpc still hasn't been updated to use module_init(), so
> initialization of the new buffer slab was only working when you used
> the thing as a module. Sorry for not having spotted that one.
> 
> I've put out a fixed copy of the knfsd over TCP patch (and the NFS_ALL
> patch).

strightforward, thanks.

Andrea
