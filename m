Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSITSmc>; Fri, 20 Sep 2002 14:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263323AbSITSmb>; Fri, 20 Sep 2002 14:42:31 -0400
Received: from adsl-64-160-52-243.dsl.snfc21.pacbell.net ([64.160.52.243]:37828
	"EHLO gateway.sf.frob.com") by vger.kernel.org with ESMTP
	id <S263280AbSITSl5>; Fri, 20 Sep 2002 14:41:57 -0400
Date: Fri, 20 Sep 2002 11:40:43 -0700
Message-Id: <200209201840.g8KIehO28302@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: phil-list@redhat.com
Cc: Luca Barbieri <ldb@ldb.ods.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: Ingo Molnar's message of  Friday, 20 September 2002 13:19:35 +0200 <Pine.LNX.4.44.0209201317540.3831-100000@localhost.localdomain>
X-Zippy-Says: ...PENGUINS are floating by...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 20 Sep 2002, Luca Barbieri wrote:
> 
> > Great, but how about using code similar to the following rather than
> > hand-coded asm operations?
> > 
> > extern struct pthread __pt_current_struct asm("%gs:0");
> > #define __pt_current (&__pt_current_struct)

Try that under -fpic and you will see the problem.
