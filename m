Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132158AbRAIVi0>; Tue, 9 Jan 2001 16:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132152AbRAIViQ>; Tue, 9 Jan 2001 16:38:16 -0500
Received: from ns1.megapath.net ([216.200.176.4]:787 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S131858AbRAIViC>;
	Tue, 9 Jan 2001 16:38:02 -0500
Message-ID: <3A5B847A.3010200@megapathdsl.net>
Date: Tue, 09 Jan 2001 13:36:58 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac1 i686; en-US; m18) Gecko/20010107
X-Accept-Language: en
MIME-Version: 1.0
To: JP Navarro <navarro@mcs.anl.gov>
CC: Ken Brunsen/Iris <kenbo@iris.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.0 scsi problems on NetFinity servers
In-Reply-To: <OF0CDA4866.9019CFB7-ON852569CF.006D12FC@lotus.com> <3A5B7DB3.F29D02CE@mcs.anl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JP Navarro wrote:

> One possibility:
> 
> When we first tested 2.4.0-test8 on NetFinity 7000s we had random crashes,
> typically within an hour of booting. The problem was identified as a Wiseman
> Systems Management adapter generated hardware interrupt that 2.4 doesn't handle
> (this was not a problem with 2.2.x).
> 
> If you have these adapters installed, remove them.

Are you saying that this is a hardware bug that is impossible to
develop a work-around for in the kernel?  If this is just a bug,
shouldn't we try to fix it rather than avoid it?

If you have detailed information about the interrupt problem,
perhaps you could send it to the list and see if a fix is possible.

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
