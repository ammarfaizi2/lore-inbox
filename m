Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288926AbSBDMBw>; Mon, 4 Feb 2002 07:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288936AbSBDMBm>; Mon, 4 Feb 2002 07:01:42 -0500
Received: from elin.scali.no ([62.70.89.10]:19979 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S288926AbSBDMBd>;
	Mon, 4 Feb 2002 07:01:33 -0500
Message-ID: <3C5E7808.61564FD1@scali.com>
Date: Mon, 04 Feb 2002 13:01:12 +0100
From: Steffen Persvold <sp@scali.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Short question regarding generic_make_request()
In-Reply-To: <Pine.LNX.4.33.0202041315200.4046-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> 
> this shows some sort of wakeup or softirq handling irregularity. A number
> of softirq latency bugs were fixed, i'd suggest to try this with any
> recent kernel (or recent errata kernel rpms).
> 

I just testet the latest RedHat errata kernel (2.4.9-21) and it performs badly with a kernel thread.
Is there a simple patch out there that fixes this problem on a 2.4.9 kernel (I guess it's only
related to the network stack) so that I can send it to RedHat's bugzilla system ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
