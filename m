Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264155AbUESNQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUESNQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 09:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264161AbUESNQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 09:16:42 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:57264 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264155AbUESNQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 09:16:33 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       "Justin Piszcz" <jpiszcz@hotmail.com>, <baldrick@free.fr>,
       <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5.
Date: Wed, 19 May 2004 15:16:51 +0200
User-Agent: KMail/1.5.3
Cc: <linux-kernel@vger.kernel.org>
References: <5D3C2276FD64424297729EB733ED1F7605FAEB88@email1.mitretek.org>
In-Reply-To: <5D3C2276FD64424297729EB733ED1F7605FAEB88@email1.mitretek.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405191516.51913.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 of May 2004 14:28, Piszcz, Justin Michael wrote:
> It may not dause -data corruption- but it deleted a whole bunch of files
> that were in use before the previous reboot.

deleting a bunch of files is a data corruption

You picked IDE cache fixes as a cause of your problems without any
verification or proof - 2.6.6 contains also a lot of VM and FS changes.

Stop spreading FUD or verify that IDE changes are to blame!
[ I will happily fix it if it turns out to be IDE. ]

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Bartlomiej
> Zolnierkiewicz
> Sent: Tuesday, May 18, 2004 9:23 AM
> To: Justin Piszcz; baldrick@free.fr; gene.heskett@verizon.net
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5.
>
> On Monday 17 of May 2004 17:06, Justin Piszcz wrote:
> > Sorry to all, it turns out (in two separate cases I had two different
> > problems that affected the results).
> >
> > Case 1: No SMP turned on for CPU w/HT after fix (~4.78 seconds compile
>
> time
>
> > (2.6GHZ w/HT))
> > Case 2: Box had 4GB of NON-ECC memory in it, only recognized 2.56GB,
>
> took
>
> > out (2) 1GB DDR DIMM's, and the speed returned what it should be.
>
> (~4.3
>
> > seconds compile time (3.0GHZ w/HT))
> >
> > The control box was a 2.53GHZ (533MHZ BUS w/NO HT) = ~5.3seconds
> >
> > I have not tested 2.6.6 recently, but in one of my tests I believe it
> > worked OK, ever since 2.6.6 removed my /etc/lilo.conf and /etc/mtab
>
> and
>
> > several other files, I do not wish to touch that kernel with a 10 foot
>
> poll
>
> > :-P due to the IDE disk flush/cache issue.
>
> I told you this already: 2.6.6 IDE changes don't cause data corruption
> - but fixes some instead (that's why there were merged so quickly!)
> so stop spreading FUD and see
> http://bugme.osdl.org/show_bug.cgi?id=2672.

