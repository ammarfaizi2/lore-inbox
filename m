Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUCTCua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 21:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUCTCua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 21:50:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:22419 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263204AbUCTCu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 21:50:26 -0500
Date: Fri, 19 Mar 2004 18:50:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark Wong <markw@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-Id: <20040319185026.56db3bf7.akpm@osdl.org>
In-Reply-To: <20040319183906.I8594@osdlab.pdx.osdl.net>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	<200403181737.i2IHbCE09261@mail.osdl.org>
	<20040318100615.7f2943ea.akpm@osdl.org>
	<20040318192707.GV22234@suse.de>
	<20040318191530.34e04cb2.akpm@osdl.org>
	<20040318194150.4de65049.akpm@osdl.org>
	<20040319183906.I8594@osdlab.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Wong <markw@osdl.org> wrote:
>
> On Thu, Mar 18, 2004 at 07:41:50PM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > Mark, if it's OK I'll run up some kernels for you to test.
> > 
> > At
> > 
> > 	http://www.zip.com.au/~akpm/linux/patches/markw/
> 
> Ok, looks like I take the first hit with the 02 patch.  Here's re-summary:
> 
> kernel          16 kb   32 kb   64 kb   128 kb  256 kb  512 kb
> 2.6.3                           2308    2335    2348    2334
> 2.6.4-mm2       2028    2048    2074    2096    2082    2078
> 2.6.5-rc1-01                                            2394
> 2.6.5-rc1-02                                            2117
> 2.6.5-rc1-mm2                                           2036

Thanks, so it's the CPU scheduler changes.  Is that machine hyperthreaded? 
And do you have CONFIG_X86_HT enabled?

