Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTFALNA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 07:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTFALNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 07:13:00 -0400
Received: from imsantv20.netvigator.com ([210.87.250.76]:29372 "EHLO
	imsantv20.netvigator.com") by vger.kernel.org with ESMTP
	id S264396AbTFALM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 07:12:58 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Andreas Hartmann <andihartmann@freenet.de>
Subject: Re: [PATCH] rmap 15j for 2.4.21-rc6
Date: Sun, 1 Jun 2003 19:26:00 +0800
User-Agent: KMail/1.5.2
References: <fa.nvklblk.jl430u@ifi.uio.no> <fa.h329tc5.1djcrol@ifi.uio.no> <bbcmc6$74t$1@ID-44327.news.dfncis.de>
In-Reply-To: <bbcmc6$74t$1@ID-44327.news.dfncis.de>
Cc: linux-kernel@vger.kernel.org
X-OS: GNU/Linux 2.5.70
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306011926.00994.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 June 2003 19:00, Andreas Hartmann wrote:
>
> Well, I did the test with 2.4.21rc6 after patching your script (I got
> syntax errors):

About your script changes, I like to make it portable, and I use the 
following versions:

GNU bash, version 2.05b.0(1)-release (i386-redhat-linux-gnu)

dd (coreutils) 4.5.3

What shell and coreutils are you using?

Avoiding short counts is easy but avoiding C-style expressions is primitive

-     count=100K
+     count=100000

-   while (( i-- )); do
+   while (( i=`expr $i - 1` )); do

In your opinion are your changes more portable across a wide range of systems? 

>
> When I'm using the script as seen in the patch, I'm getting problems with
> df (it's mostly very lazy, about 20s delay or more), the load is 4, doing
> an ls on some other directories is extremly slow. Mouse and keyboard are
> hanging some times.
> The write speed shown in xosview was between 1 and 15MB/s. Often the HD LED
> was on, but no data seemed to be put to the HD.
>

It has a hard time to read anything else, the slower the disk, the worse. 

Suppose rmap undoes the fixes introduced in -rc6. 

Have you tried -rc6 plain?


Regards
Michael

