Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292785AbSB0VbR>; Wed, 27 Feb 2002 16:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292880AbSB0Vat>; Wed, 27 Feb 2002 16:30:49 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:12672 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292969AbSB0Vaa>; Wed, 27 Feb 2002 16:30:30 -0500
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF489D60A6.86F20AEB-ON85256B6D.0075A937@raleigh.ibm.com>
From: "Niels Christiansen" <nchr@us.ibm.com>
Date: Wed, 27 Feb 2002 15:30:25 -0600
X-MIMETrack: Serialize by Router on D04NM104/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/27/2002 04:30:29 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I have a concern about the lockmeter results.  Lockmeter appears
> to be measuring lock frequency and hold times and contention.  But
> is it measuring the cost of the cacheline transfers?

No.

> I expect that with delayed allocation and radix-tree pagecache, one
> of the major remaining bottlenecks will be ownership of the superblock
> semaphore's cacheline.   Is this measurable?
When you ask if this is measurable, exactly what do you mean?  The cost
of cacheline transfers?  Expressed in which unit of measure?  Bottlenecks?

If the data you are after is available, a tool can surely be made
to capture and present it...

-nc-

