Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbTBKGuc>; Tue, 11 Feb 2003 01:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267149AbTBKGub>; Tue, 11 Feb 2003 01:50:31 -0500
Received: from angband.namesys.com ([212.16.7.85]:57218 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267118AbTBKGua>; Tue, 11 Feb 2003 01:50:30 -0500
Date: Tue, 11 Feb 2003 10:00:11 +0300
From: Oleg Drokin <green@namesys.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: David Ford <david+powerix@blue-labs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Current NFS issues (2.5.59)
Message-ID: <20030211100011.A5850@namesys.com>
References: <3E46E1D6.20709@blue-labs.org> <15944.30340.955911.798377@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15944.30340.955911.798377@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Feb 11, 2003 at 03:05:24PM +1100, Neil Brown wrote:

> > 3. Mount point F (/home/david) infrequently loops.  ls -la /home/david 
> > will loop forever until all client memory is exhausted and the kernel 
> > kills it via OOM.  ls -la /home/david/somefile or /home/david/somedir/ 
> > works just fine as well as any sub directory under /home/david.  
> > Restarts of both systems refuse to fix things.
> I think this might be a reiserfs problem.  Someone else mentioned that

I was not able to reproduce that.

> this started happening when they upgrade from an earlier 2.5 kernel.

I think that earlier report was from David too. This is just more detailed
report it seems.

And while you are listening - I want to share my own NFs problems in 2.5.59 ;)
If I try to mount any NFS exported filesystem from the same host (e.g
localhost), mount process hangs in D state. Server appears to work ok though
and serves requests from external clients.

Bye,
    Oleg
