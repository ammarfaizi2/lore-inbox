Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273365AbRINMDt>; Fri, 14 Sep 2001 08:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273367AbRINMDk>; Fri, 14 Sep 2001 08:03:40 -0400
Received: from ns.caldera.de ([212.34.180.1]:45976 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S273365AbRINMDa>;
	Fri, 14 Sep 2001 08:03:30 -0400
Date: Fri, 14 Sep 2001 14:03:39 +0200
Message-Id: <200109141203.f8EC3d312998@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: mozgy@hinet.hr (Mario Mikocevic)
Cc: linux-kernel@vger.kernel.org
Subject: Re: v2410p8 and v2410p9 are no go
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010914134415.A802@danielle.hinet.hr>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010914134415.A802@danielle.hinet.hr> you wrote:
> Hi,

> kernels 2.4.10-pre8 and 2.4.10-pre9 are NoGo for me,
> last kernel I tried and it still runs succesfully is 2.4.10-pre4.

> dmesg difference is ->

> - hda: [PTBL] [5171/240/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
> - hdd: [PTBL] [787/128/63] hdd1
> + hda: no partitions found
> + hdd: no partitions found

That looks like the gendisk changes..
Anything special with that machine?  (IDE driver?).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
