Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWDDNwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWDDNwB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 09:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWDDNwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 09:52:01 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:54188 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S932163AbWDDNwA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 09:52:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problem with diskstats (kernel 2.6.15-gentoo-r1)
Date: Tue, 4 Apr 2006 08:51:59 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10BE8D29D@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with diskstats (kernel 2.6.15-gentoo-r1)
Thread-Index: AcZVX2QAsEa9V6zTQ9yOzybjnKHlPgCj0BWw
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Toon van der Pas" <toon@hout.vanvergehaald.nl>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Apr 2006 13:51:59.0493 (UTC) FILETIME=[F1AA2350:01C657EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Toon van der Pas [mailto:toon@hout.vanvergehaald.nl] 
> Sent: Saturday, April 01, 2006 1:39 AM
> To: linux-kernel@vger.kernel.org; Miller, Mike (OS Dev)
> Subject: Problem with diskstats (kernel 2.6.15-gentoo-r1)
> 
> Hi,
> 
> This morning I discovered a strange problem with the output 
> of /proc/diskstats; the cciss driver only produces the first 4 fields:
> 
> # cat /proc/diskstats
>    2    0 fd0 0 0 0 0 0 0 0 0 0 0 0
>    1    0 ram0 0 0 0 0 0 0 0 0 0 0 0
---
---
---
>    7    6 loop6 0 0 0 0 0 0 0 0 0 0 0
>    7    7 loop7 0 0 0 0 0 0 0 0 0 0 0
>  104    0 cciss/c0d0 847389 32332 0 2982364 1619046 4086174 0
> 52598252 0 12069816 55580352
>  104    1 cciss/c0d0p1 554 52382 7 20
>  104    2 cciss/c0d0p2 29 232 42 336
>  104    3 cciss/c0d0p3 84233 5811794 1516187 12129496
>  104    4 cciss/c0d0p4 795049 17425244 4190632 33525064
>  104   16 cciss/c0d1 86563628 212593 0 655297532 13528298 14360980 0
> 1485869084 502 371162916 2142684840
>  104   17 cciss/c0d1p1 86776123 1102284661 27890200 223121616
>    3    0 hda 0 0 0 0 0 0 0 0 0 0 0
>  254    0 dm-0 0 0 0 0 0 0 0 0 0 0 0
>  254    1 dm-1 0 0 0 0 0 0 0 0 0 0 0
>  254    2 dm-2 0 0 0 0 0 0 0 0 0 0 0
>  254    3 dm-3 0 0 0 0 0 0 0 0 0 0 0
>  254    4 dm-4 0 0 0 0 0 0 0 0 0 0 0
>  254    5 dm-5 0 0 0 0 0 0 0 0 0 0 0
>  254    6 dm-6 0 0 0 0 0 0 0 0 0 0 0
>  254    7 dm-7 0 0 0 0 0 0 0 0 0 0 0
> 
> Maybe the cciss maintainer can comment?

I'm not sure what to comment. I've not made any changes for diskstats to
work with cciss. Or is your concern that no other devices seem to work?

mikem

> Regards,
> Toon.
> 
