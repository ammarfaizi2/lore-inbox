Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbUCRBP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 20:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbUCRBP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 20:15:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:2464 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262269AbUCRBPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 20:15:21 -0500
Subject: Re: 2.6.4-mm2
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Mason <mason@suse.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20040317163332.0385d665.akpm@osdl.org>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	 <1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
	 <1079474312.4186.927.camel@watt.suse.com>
	 <20040316152106.22053934.akpm@osdl.org>
	 <20040316152843.667a623d.akpm@osdl.org>
	 <20040316153900.1e845ba2.akpm@osdl.org>
	 <1079485055.4181.1115.camel@watt.suse.com>
	 <1079487710.3100.22.camel@ibm-c.pdx.osdl.net>
	 <20040316180043.441e8150.akpm@osdl.org>
	 <1079554288.4183.1938.camel@watt.suse.com>
	 <20040317123324.46411197.akpm@osdl.org>
	 <1079563568.4185.1947.camel@watt.suse.com>
	 <20040317150909.7fd121bd.akpm@osdl.org>
	 <1079566076.4186.1959.camel@watt.suse.com>
	 <20040317155111.49d09a87.akpm@osdl.org>
	 <1079568387.4186.1964.camel@watt.suse.com>
	 <20040317161338.28b21c35.akpm@osdl.org>
	 <1079569870.4186.1967.camel@watt.suse.com>
	 <20040317163332.0385d665.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1079572511.6930.5.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Mar 2004 17:15:12 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running without clear_page_dirty_for_io.patch on an 8-proc
with 6 direct_read_under tests on ext3.

2 failed in less than 5 minutes.  The 4 others are still running
and it's been over 30 minutes.

I'll run overnight wth clear_page_dirty_for_io.patch added in.

Daniel
On Wed, 2004-03-17 at 16:33, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > good news is that direct_read_under is still running without
> >  problems here.
> 
> Here also, but _without_ clear_page_dirty_for_io.patch, so it should break.
> 
> Maybe it takes a long time.

