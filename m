Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132228AbRAIW0J>; Tue, 9 Jan 2001 17:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132163AbRAIWZt>; Tue, 9 Jan 2001 17:25:49 -0500
Received: from cliff.mcs.anl.gov ([140.221.9.17]:48768 "EHLO mcs.anl.gov")
	by vger.kernel.org with ESMTP id <S131615AbRAIWZk>;
	Tue, 9 Jan 2001 17:25:40 -0500
Message-ID: <3A5B8F34.125231D4@mcs.anl.gov>
Date: Tue, 09 Jan 2001 16:22:44 -0600
From: JP Navarro <navarro@mcs.anl.gov>
Organization: Argonne National Laboratory
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: Ken Brunsen/Iris <kenbo@iris.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.0 scsi problems on NetFinity servers
In-Reply-To: <OF0CDA4866.9019CFB7-ON852569CF.006D12FC@lotus.com> <3A5B7DB3.F29D02CE@mcs.anl.gov> <3A5B847A.3010200@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
...
> Are you saying that this is a hardware bug that is impossible to
> develop a work-around for in the kernel?  If this is just a bug,
> shouldn't we try to fix it rather than avoid it?

This is hardware behaving as designed but not supported by the kernel. IBM was
aware of the problem and working on a solution. Since the offending hardware is
a PCI card that is useless under Linux. The simple solution is to remove it.

If IBM wants these cards to work with Linux they should do a lot more than
supply patches that keep the kernel from crashing.  At a minimum, publish specs
so someone else can patch the kernel and write drivers to make full use of the
card's features under Linux. We're still hoping.

> If you have detailed information about the interrupt problem,
> perhaps you could send it to the list and see if a fix is possible.

Wish I could have. Our machines would totally freeze.

JP Navarro
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
