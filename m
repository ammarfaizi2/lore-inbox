Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267406AbUH1Jxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267406AbUH1Jxt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUH1JxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:53:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:16267 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267406AbUH1JsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:48:15 -0400
Date: Sat, 28 Aug 2004 02:45:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nickpiggin@yahoo.com.au, linuxram@us.ibm.com, hugh@veritas.com,
       dice@mfa.kfki.hu, vda@port.imtp.ilyichevsk.odessa.ua,
       linux-kernel@vger.kernel.org
Subject: Re: data loss in 2.6.9-rc1-mm1
Message-Id: <20040828024504.70407b43.akpm@osdl.org>
In-Reply-To: <200408281144.50704.rjw@sisk.pl>
References: <Pine.LNX.4.44.0408271950460.8349-100000@localhost.localdomain>
	<1093669312.11648.80.camel@dyn319181.beaverton.ibm.com>
	<41301E27.2020504@yahoo.com.au>
	<200408281144.50704.rjw@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Well, guys, to make it 100% clear: if I apply the Nick's patch to the 
>  2.6.9-rc1-mm1 tree, it will fix the data loss issue.  Is that right?

Should do.  Or revert

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one-cleanup.patch

and then

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one.patch


