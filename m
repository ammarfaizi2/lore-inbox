Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263777AbUESDv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUESDv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 23:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbUESDv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 23:51:57 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5580 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263777AbUESDv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 23:51:56 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Justin Piszcz" <jpiszcz@hotmail.com>, baldrick@free.fr,
       gene.heskett@verizon.net
Subject: Re: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5.
Date: Tue, 18 May 2004 15:23:20 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <BAY18-F106WMUe77sHG0002bb5f@hotmail.com>
In-Reply-To: <BAY18-F106WMUe77sHG0002bb5f@hotmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405181519.17233.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 of May 2004 17:06, Justin Piszcz wrote:
> Sorry to all, it turns out (in two separate cases I had two different
> problems that affected the results).
>
> Case 1: No SMP turned on for CPU w/HT after fix (~4.78 seconds compile time
> (2.6GHZ w/HT))
> Case 2: Box had 4GB of NON-ECC memory in it, only recognized 2.56GB, took
> out (2) 1GB DDR DIMM's, and the speed returned what it should be. (~4.3
> seconds compile time (3.0GHZ w/HT))
>
> The control box was a 2.53GHZ (533MHZ BUS w/NO HT) = ~5.3seconds
>
> I have not tested 2.6.6 recently, but in one of my tests I believe it
> worked OK, ever since 2.6.6 removed my /etc/lilo.conf and /etc/mtab and
> several other files, I do not wish to touch that kernel with a 10 foot poll
> :-P due to the IDE disk flush/cache issue.

I told you this already: 2.6.6 IDE changes don't cause data corruption
- but fixes some instead (that's why there were merged so quickly!)
so stop spreading FUD and see http://bugme.osdl.org/show_bug.cgi?id=2672.

