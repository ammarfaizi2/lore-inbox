Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUABBAj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 20:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUABBAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 20:00:39 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:9381 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262040AbUABBAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 20:00:34 -0500
Date: Fri, 2 Jan 2004 01:59:45 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
Message-ID: <20040102005945.GJ32477@louise.pinerecords.com>
References: <20040101043333.186a3268.pj@sgi.com> <1072977297.1399.14.camel@nidelv.trondhjem.org> <20040101151516.236cb610.pj@sgi.com> <1073004403.1376.14.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073004403.1376.14.camel@nidelv.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan-01 2004, Thu, 19:46 -0500
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> P? to , 01/01/2004 klokka 18:15, skreiv Paul Jackson:
> 
> > Have you knowledge that more recent versions of gcc don't complain
> > nearly as much of this warning?  If so, I will upgrade my gcc and shut
> > up.
> 
> I haven't checked with Andrew's '-mm' kernels, but AFAICS I'm not seeing
> any lingering signed/unsigned warnings in the stock 2.6.0 kernel -
> certainly not as many as 1386... (GCC version is latest 3.3.3 prerelease
> from Debian).

I'm not sure, but wasn't this kind of warning moved
from under '-Wall' to under '-W'?

gcc 3.3.2's manpage says:

       -W  Print extra warning messages for these events:

           ...

           o   A comparison between signed and unsigned values
               could produce an incorrect result when the signed
               value is converted to unsigned.  (But don't warn
               if -Wno-sign-compare is also specified.)

-- 
Tomas Szepe <szepe@pinerecords.com>
