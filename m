Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUEPDV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUEPDV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 23:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUEPDV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 23:21:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:35485 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262927AbUEPDV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 23:21:26 -0400
Date: Sat, 15 May 2004 20:20:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: adi@bitmover.com, scole@lanl.gov, support@bitmover.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040515202054.32bf06d5.akpm@osdl.org>
In-Reply-To: <200405151923.41353.elenstev@mesatop.com>
References: <200405132232.01484.elenstev@mesatop.com>
	<5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14>
	<20040514204153.0d747933.akpm@osdl.org>
	<200405151923.41353.elenstev@mesatop.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
>  For reference, here is Andy's script again:
>  #!/bin/sh
>  x=0
>  while true; do
>          bk clone -qlr40514130hBbvgP4CvwEVEu27oxm46w testing-2.6 foo
>          (cd foo; bk pull -q)
>          rm -rf foo
>          x=`expr $x + 1`
>          echo -n "$x "
>  done

Two hours so far here.

bix:/usr/src> ~/clone.sh 
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 

That's 2.6.6-mm2+, 2GB 4-way x86.
