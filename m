Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267988AbRGZObT>; Thu, 26 Jul 2001 10:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267992AbRGZObJ>; Thu, 26 Jul 2001 10:31:09 -0400
Received: from nef.ens.fr ([129.199.96.32]:44818 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S267988AbRGZObB>;
	Thu, 26 Jul 2001 10:31:01 -0400
Date: Thu, 26 Jul 2001 16:30:53 +0200
From: David Madore <david.madore@ens.fr>
To: James Washer <washer@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ed.Connell@sas.com, jbarkal@us.ibm.com
Subject: Re: *very* strange heisenbug (kernel? libc?)
Message-ID: <20010726163053.A18411@clipper.ens.fr>
In-Reply-To: <OFABC710C2.8C05140F-ON88256A94.006BEA68@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFABC710C2.8C05140F-ON88256A94.006BEA68@boulder.ibm.com>; from washer@us.ibm.com on Wed, Jul 25, 2001 at 12:48:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, Jul 25, 2001 at 12:48:43PM -0700, James Washer wrote:
> Almost certainly, the bug you are experiencing is the same bug we reported
> yesterday under the subject "switch_mm() can fail to load ldt on SMP".

Thanks.  Please keep us informed.  It may also be of use to write to
the bug-glibc@gnu.org mailing-list to mention that that problem does
*not* come from the libc (although it seems that nobody was
interested, anyway).

<URL: http://sources.redhat.com/ml/bug-glibc/2001-07/msg00076.html >
describes some other problems which seem to be somehow connected to
kernel-2.4+glibc-2.2(libpthread).  I'll review the list when the LDT
problem has been fixed to see if other bugs have disappeared
automagically.

Happy hacking,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.eleves.ens.fr:8080/home/madore/ )
