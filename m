Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRJTPRm>; Sat, 20 Oct 2001 11:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273349AbRJTPRc>; Sat, 20 Oct 2001 11:17:32 -0400
Received: from 213-187-164-5.dd.nextgentel.com ([213.187.164.5]:24721 "EHLO
	mushkin.ii.uib.no") by vger.kernel.org with ESMTP
	id <S273333AbRJTPRX>; Sat, 20 Oct 2001 11:17:23 -0400
Date: Sat, 20 Oct 2001 17:17:30 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: Christoph Rohland <cr@sap.com>
Cc: ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Message-ID: <20011020171730.A28057@parallab.uib.no>
Mail-Followup-To: Jan-Frode Myklebust <janfrode@parallab.uib.no>,
	Christoph Rohland <cr@sap.com>,
	ML-linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com> <m33d4gjaoa.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m33d4gjaoa.fsf@linux.local>; from cr@sap.com on Fri, Oct 19, 2001 at 10:28:37AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 10:28:37AM +0200, Christoph Rohland wrote:
> > 
> > Is tmpfs stable?
> 
> I merged the tmpfs from -ac into the stock kernel. So there was
> something changed which maybe is broken. Were there any kernel
> messages, oopses?
> 
> Exactly the parallel kernel make is one of my regression tests for
> tmpfs. Further on I do not see how tmpfs should interfere with the
> library pages. make, ls etc use tmpfs pages. So I suspect it's
> something else.
> 


Running BitKeeper regression tests fails for me on tmpfs /tmp/. I have
reported it to the bitkeeper bugtracking, but am not sure if this is a
bitkeeper or tmpfs bug. Any insight?

	http://bitkeeper.bkserver.com/cgi-bin/bugview?open/2001-09-11-001 

Last tested with Bitkeeper 2.0 on linux 2.4.10-xfs.


  -jf
