Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTKHXWI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 18:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTKHXWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 18:22:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:62676 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261270AbTKHXWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 18:22:04 -0500
Date: Sat, 8 Nov 2003 15:25:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mr. Mailing List" <mailinglistaddie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: will this bug be addressed before test10?
Message-Id: <20031108152534.468f9a03.akpm@osdl.org>
In-Reply-To: <20031108083553.17849.qmail@web60206.mail.yahoo.com>
References: <20031108083553.17849.qmail@web60206.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mr. Mailing List" <mailinglistaddie@yahoo.com> wrote:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=1229
> 
>  It's made it this far, and it's still just as horrible
>  a bug:(

In the report you say that 2.6.0-test2 was OK and 2.6.0-test3 was not?

Over at

	http://www.zip.com.au/~akpm/linux/patches/test3/

you will find all the changesets between test2 and test3.  Each patch there
is against test2.  If you have the time, it would be useful to work out
which of those patches introduced the problem.  The chronological order of
those patches is

cset-20030727_1716.txt.gz
cset-20030801_0319.txt.gz
cset-20030801_0621.txt.gz
cset-20030801_1815.txt.gz
cset-20030801_1922.txt.gz
cset-20030801_2316.txt.gz
cset-20030802_0314.txt.gz
cset-20030802_0612.txt.gz
cset-20030802_1915.txt.gz
cset-20030803_0116.txt.gz
cset-20030803_0209.txt.gz
cset-20030803_2013.txt.gz
cset-20030804_2010.txt.gz
cset-20030804_2110.txt.gz
cset-20030805_0012.txt.gz
cset-20030805_1908.txt.gz
cset-20030805_2315.txt.gz
cset-20030806_0009.txt.gz
cset-20030806_0510.txt.gz
cset-20030806_0609.txt.gz
cset-20030806_0909.txt.gz
cset-20030807_0211.txt.gz
cset-20030807_0909.txt.gz
cset-20030807_1810.txt.gz
cset-20030807_1914.txt.gz
cset-20030807_2017.txt.gz
cset-20030807_2109.txt.gz
cset-20030807_2311.txt.gz
cset-20030808_0118.txt.gz
cset-20030808_0310.txt.gz
cset-20030808_1816.txt.gz
cset-20030809_0113.txt.gz
cset-20030809_0411.txt.gz

It should be possible to do this in six compile-n-boot cycles ;)

Thanks.
