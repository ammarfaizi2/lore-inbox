Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130408AbQKNQze>; Tue, 14 Nov 2000 11:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131044AbQKNQzY>; Tue, 14 Nov 2000 11:55:24 -0500
Received: from host55.osagesoftware.com ([209.142.225.55]:32267 "EHLO
	netmax.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S130408AbQKNQzR>; Tue, 14 Nov 2000 11:55:17 -0500
Message-Id: <4.3.2.7.2.20001114112453.00b94a90@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 14 Nov 2000 11:25:03 -0500
To: Daniel Phillips <phillips@innominate.de>
From: David Relson <relson@osagesoftware.com>
Subject: Re: Modprobe local root exploit
Cc: linux-kernel@vger.kernel.org, Peter Samuelson <peter@cadcamlab.org>
In-Reply-To: <news2mail-3A114AF6.44AA8032@innominate.de>
In-Reply-To: <14864.5656.706778.275865@ns.caldera.de>
 <Pine.LNX.4.21.0011131744100.594-100000@toy.mandrakesoft.com>
 <14864.6812.849398.988598@ns.caldera.de>
 <20001113134630.C18203@wire.cadcamlab.org>
 <news2mail-3A112225.F29226B6@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

At 09:23 AM 11/14/00, you wrote:
I reserve the right to make coding errors, thanks for not letting it get
written into history :-)

I'm not going to give up my right to make errors until I'm ready to give up 
my keyboard.  I'll probably be pushing up daisies at that point in my life.


How about:

   for ( ... ) if (!isalnum(*p) && !strchr("-_", *p)) return -EINVAL;


I think that is correct.  However, it fails the "easy to understand" 
criterion, so I don't like it.]

David
--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       514 W. Keech Ave.
www.osagesoftware.com          Ann Arbor, MI 48103
voice: 734.821.8800            fax: 734.821.8800

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
