Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132808AbRDYWJT>; Wed, 25 Apr 2001 18:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132805AbRDYWJH>; Wed, 25 Apr 2001 18:09:07 -0400
Received: from www.inreko.ee ([195.222.18.2]:6390 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S132808AbRDYWIm>;
	Wed, 25 Apr 2001 18:08:42 -0400
Date: Thu, 26 Apr 2001 00:24:37 +0200
From: Marko Kreen <marko@l-t.ee>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Doug McNaught <doug@wireboard.com>,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, tim@tjansen.de,
        linux-kernel@vger.kernel.org
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
Message-ID: <20010426002437.B2813@l-t.ee>
In-Reply-To: <01042522404901.00954@cookie> <200104252116.QAA46520@tomcat.admin.navo.hpc.mil> <20010425235000.A3432@werewolf.able.es> <m34rvcy73o.fsf@belphigor.mcnaught.org> <20010426000325.A6621@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010426000325.A6621@werewolf.able.es>; from jamagallon@able.es on Thu, Apr 26, 2001 at 12:03:25AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 12:03:25AM +0200, J . A . Magallon wrote:
> 
> On 04.25 Doug McNaught wrote:
> > "J . A . Magallon" <jamagallon@able.es> writes:
> > 
> > > Question: it is possible to redirect the same fs call (say read) to
> > different
> > > implementations, based on the open mode of the file descriptor ? So, if
> > > you open the entry in binary, you just get the number chunk, if you open
> > > it in ascii you get a pretty printed version, or a format description like
> > 
> > There is no distinction between "text" and "binary" modes on a file
> > descriptor.  The distinction exists in the C stdio layer, but is a
> > no-op on Unix systems.
> > 
> 
> Yep, realized after the post, fopen() is a wrapper for open(). The idea
> is to (someway) set the proc entry in verbose vs fast-binary mode for
> reads. Perhaps an ioctl() or an fcntl() or something similar.
> So the verbose mode gives the field names, and the binary mode just
> gives the numbers. Applications that know what are reading can just
> read binary data, and fast.

Eh.  Search in archives for "ascii is tough"...

-- 
marko

