Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUCRAji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUCRAji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:39:38 -0500
Received: from ns.suse.de ([195.135.220.2]:58272 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262217AbUCRAjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:39:25 -0500
Subject: Re: 2.6.4-mm2
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: daniel@osdl.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org
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
Message-Id: <1079570515.4183.1973.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 19:41:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 19:33, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > good news is that direct_read_under is still running without
> >  problems here.
> 
> Here also, but _without_ clear_page_dirty_for_io.patch, so it should break.
> 
> Maybe it takes a long time.

It was very irregular for me.  A run might die in pass3 or last for 30
minutes before I got bored and hit ctrl-c

-chris


