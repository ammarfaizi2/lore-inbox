Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUABAJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUABAJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:09:28 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:58788 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261784AbUABAJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:09:27 -0500
Date: Fri, 2 Jan 2004 01:08:36 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
Message-ID: <20040102000836.GC32477@louise.pinerecords.com>
References: <20040101043333.186a3268.pj@sgi.com> <1072977297.1399.14.camel@nidelv.trondhjem.org> <20040101151516.236cb610.pj@sgi.com> <20040101153303.75d37307.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101153303.75d37307.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan-01 2004, Thu, 15:33 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Paul Jackson <pj@sgi.com> wrote:
> >
> >  Right now, compiling a 2.6.0-mm1 (what I had handy) with the 3.3 gcc on
> >  my Pentium system for arch i386 generates 1386 signed and unsigned
> >  warnings
> 
> ugh, that is unacceptable.
> 
> Unless anyone has a better idea, yes, we should apply your patch.

Hmm, this doesn't happen for me with gcc 3.3.2.  Paul, could you please
send me your .config?  (Off-list, preferably.)

-- 
Tomas Szepe <szepe@pinerecords.com>
