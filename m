Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbULTADz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbULTADz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 19:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbULTADy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 19:03:54 -0500
Received: from webmail.sub.ru ([213.247.139.22]:36100 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S261357AbULTADx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 19:03:53 -0500
From: Mikhail Ramendik <mr@ramendik.ru>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Date: Mon, 20 Dec 2004 03:03:35 +0300
User-Agent: KMail/1.7.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lista4@comhem.se,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
References: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2> <41C6073B.6030204@yahoo.com.au> <20041219155722.01b1bec0.akpm@digeo.com>
In-Reply-To: <20041219155722.01b1bec0.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412200303.35807.mr@ramendik.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> - Ask Voluspa to do
>
> 	echo 0 > /proc/sys/vm/swap_token_timeout
>
>   on 2.6.10-rc3 and retest.

He did, and I did (but I have not sent my report to lkml). In both cases, 
screen freezes remained but were now less in duration (up to 10-20 sec). In 
mu case I also monitored CPU loading and the big load peaks were there (the 
biggest one was in the beginning).

> (We still don't know why it chews tons of CPU, do we?)

It does! Any way to dig into this?

-- 
Yours, Mikhail Ramendik

