Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUFQNj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUFQNj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUFQNj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:39:27 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:20871 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266491AbUFQNjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:39:24 -0400
Date: Thu, 17 Jun 2004 08:38:28 -0500
From: Nathan Straz <nstraz@sgi.com>
To: David Rees <drees@greenhydrant.com>
Cc: Peter Wainwright <prw@ceiriog1.demon.co.uk>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: Irix NFS servers, again :-)
Message-ID: <20040617133828.GA20029@sgi.com>
Mail-Followup-To: David Rees <drees@greenhydrant.com>,
	Peter Wainwright <prw@ceiriog1.demon.co.uk>,
	linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
References: <1087411925.30092.35.camel@ceiriog1.demon.co.uk> <40D163C8.30507@greenhydrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D163C8.30507@greenhydrant.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 02:26:32AM -0700, David Rees wrote:
> Peter Wainwright wrote, On 6/16/2004 11:52 AM:
> >I just upgraded one of my machines to Fedora Core 2, including
> >kernel 2.6.5. I found myself bitten on the bum by a bug I thought
> >had expired long ago, namely the Irix server readdir bug, or
> >32/64-bit cookie problem.
>
> glibc.  I can't seem to reproduce it using `ls` which I remember being 
> able to last time I had the problem so that would explain it.  What 
> software showed the problem for you?

You can see the different if you do `ls dir` and `ls dir/*`.  Typically
the shell will use readdir and ls will use getdents, IIRC.  I was using
the test case readdir01 from LTP.

-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
