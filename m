Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVIIPFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVIIPFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVIIPFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:05:15 -0400
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:11837 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932557AbVIIPFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:05:13 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: <awesley@acquerra.com.au>, <linux-kernel@vger.kernel.org>
Subject: RE: kernel 2.6.13 buffer strangeness
Date: Fri, 9 Sep 2005 10:09:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcW1HW0oIIcPK4P0Sa6DTFPVpMMHHgAMpPbA
In-Reply-To: <432151B0.7030603@acquerra.com.au>
Message-ID: <EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 09 Sep 2005 15:01:41.0367 (UTC) FILETIME=[62BF3870:01C5B54F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I saw it mentioned before that the kernel only allows a certain
percentage of total memory to be dirty, I thought the number was
around 40%, and I have seen machines with large amounts of ram,
hit the 40% and then put the writing application into disk wait
until certain amounts of things are written out, and then take
it out of disk wait, and repeat when it again hits 40%, given your
rate different it would be close to 40% in 50seconds.

And I think that you mean MB(yte) not Mb(it).

                           Roger

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Anthony Wesley
> Sent: Friday, September 09, 2005 4:11 AM
> To: linux-kernel@vger.kernel.org
> Subject: Re: kernel 2.6.13 buffer strangeness
> 
> Thanks David, but if you read my original post in full you'll 
> see that I've tried that, and while I can start the write out 
> sooner by lowering /proc/sys/vm/dirty_ratio , it makes no 
> difference to the results that I am getting. I still seem to 
> run out of steam after only 50 seconds where it should take 
> about 3 minutes.
> 
> regards, Anthony
> 
> --
> Anthony Wesley
> Director and IT/Network Consultant
> Smart Networks Pty Ltd
> Acquerra Pty Ltd
> 
> Anthony.Wesley@acquerra.com.au
> Phone: (02) 62595404 or 0419409836
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

