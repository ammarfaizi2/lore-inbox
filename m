Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSGISNJ>; Tue, 9 Jul 2002 14:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317366AbSGISNI>; Tue, 9 Jul 2002 14:13:08 -0400
Received: from cpe.atm2-0-1071115.0x50c4d862.boanxx10.customer.tele.dk ([80.196.216.98]:35532
	"EHLO fugmann.dhs.org") by vger.kernel.org with ESMTP
	id <S317365AbSGISNH>; Tue, 9 Jul 2002 14:13:07 -0400
Message-ID: <3D2B2856.4040605@fugmann.dhs.org>
Date: Tue, 09 Jul 2002 20:15:50 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] using 2.5.25 with IDE
References: <Pine.SOL.4.30.0207091613350.16892-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applying the patches (incl the 98-pre patch)
gives two compile errors in tcq.c.

Fixing those (trivial), made the system crash just after finding the first HD,
giving the output: 'tcq_start'

The system was rebootable with <sys-rq><b>.

Regards
Anders Fugmann.

Bartlomiej Zolnierkiewicz wrote:
> Contrary to the popular belief 2.5.25 has only Martin's IDE-93
> and has broken locking...
> 
> If you want to run IDE on 2.5.25 get and apply:
> 
> IDE-94 by Martin
> IDE-95/96/97/98-pre by me
> 
> from:
> http://home.elka.pw.edu.pl/~bzolnier/ata/
> 
> --
> Bartlomiej

