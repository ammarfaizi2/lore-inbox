Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129659AbRBTSWZ>; Tue, 20 Feb 2001 13:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRBTSWP>; Tue, 20 Feb 2001 13:22:15 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:18926
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S130304AbRBTSVy>; Tue, 20 Feb 2001 13:21:54 -0500
Date: Tue, 20 Feb 2001 11:20:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ben LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH] make nfsroot accept server addresses from BOOTP root
Message-ID: <20010220112042.A5639@opus.bloom.county>
In-Reply-To: <20010220104415.D3150@opus.bloom.county> <Pine.LNX.4.30.0102201248290.1614-100000@today.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.30.0102201248290.1614-100000@today.toronto.redhat.com>; from bcrl@redhat.com on Tue, Feb 20, 2001 at 01:12:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 01:12:28PM -0500, Ben LaHaise wrote:
> On Tue, 20 Feb 2001, Tom Rini wrote:
> 
> > Er, say that again?  Right now, for bootp if you specify "sa=xxx.xxx.xxx.xxx"
> > Linux uses that as the host for the NFS server (which does have the side
> > effect of if TFTP server != NFS server, you don't boot).  Are you saying
> > your patch takes "rp=xxx.xxx.xxx.xxx:/foo/root" ?  Just curious, since I
> > don't know, whats the RFC say about this?
> 
> Yeah, that's the problem I was trying to work around, mostly because the

Er, the problem of having to use sa (which is TFTP server) to specify the
NFS server?

> docs on dhcpd are sufficiently vague and obscure.  Personally, I don't
> actually need tftp support, so I've just configured the system to now
> point at the NFS server.  For anyone who cares, the last patch was wrong,
> this one is right.

If the RFC doesn't say anything about the format rp= has to be in, this
is probably right.  Assuming it works. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
