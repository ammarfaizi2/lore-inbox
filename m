Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTI2RUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTI2RUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:20:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:25742 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263866AbTI2RTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:19:32 -0400
Date: Mon, 29 Sep 2003 10:20:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test6-mm1
Message-Id: <20030929102021.76e96730.akpm@osdl.org>
In-Reply-To: <1064855347.23108.5.camel@ibm-c.pdx.osdl.net>
References: <20030928191038.394b98b4.akpm@osdl.org>
	<1064855347.23108.5.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> On Sun, 2003-09-28 at 19:10, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm1
> > 
> > 
> > Lots of small things mainly.
> > 
> > The O_DIRECT-vs-buffers I/O locking changes appear to be complete, so testing
> > attention on O_DIRECT workloads would be useful.
> > 
> 
> OSDL's STP automatically ran dbt2 tests against 2.6.0-test6-mm1 this
> morning (PLM patch #2174).
> 
> The dbt2 test uses raw devices and all the runs completed successfully.

Well that's good, thanks.

Actually, it is O_DIRECT against regular files which needs the extra testing.

