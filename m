Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292407AbSBYXfj>; Mon, 25 Feb 2002 18:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292402AbSBYXfZ>; Mon, 25 Feb 2002 18:35:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60943 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292399AbSBYXek>; Mon, 25 Feb 2002 18:34:40 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.4.18
Date: 25 Feb 2002 15:34:14 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a5ehlm$1fe$1@cesium.transmeta.com>
In-Reply-To: <20020225.140851.31656207.davem@redhat.com> <3C7AB893.4090800@ellinger.de> <20020225230156.GA11786@merlin.emma.line.org> <20020225.150813.66161624.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020225.150813.66161624.davem@redhat.com>
By author:    "David S. Miller" <davem@redhat.com>
In newsgroup: linux.dev.kernel
>
>    From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
>    Date: Tue, 26 Feb 2002 00:01:56 +0100
> 
>    > And how should EXTRAVERSION be accommodated?
>    
>    sed/perl/awk -- a short five-liner "bless-rc-to-final" script should do.
> 
> Ummm... no.
> 
> This whole conversation exists because "Deleting the EXTRAVERSION
> setting from linux/Makefile" then making new diffs/tars was screwed
> up.  Doing it with a script isn't going to help this kind of problem.
> 

Sure it would.  It would make the likelihood for errors much lower.
You need to make tarballs anyway.

> I repeat: it isn't a "release candidate" if it will not match preciely
> what the final tarball/patches contains.  Anything else opens up the
> possibility for errors to be made.

I think this is much too absolutist of an approach.  There is *always*
a possibility for errors to happen, but automation can reduce the risk
a lot.

If Marcelo wants, I can write him a "bless" script that he can run
directly on master.kernel.org, which would make it trivial to avoid
error.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
