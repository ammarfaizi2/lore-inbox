Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUCUUTc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 15:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUCUUTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 15:19:32 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.27]:17414 "EHLO
	mwinf0403.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261206AbUCUUTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 15:19:30 -0500
Message-ID: <405DF8CD.4090608@free.fr>
Date: Sun, 21 Mar 2004 21:19:25 +0100
From: christophe varoqui <christophe.varoqui@free.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Device mapper devel list <dm-devel@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Thomas Horsten <thomas@horsten.com>,
       Christophe Saout <christophe@saout.de>
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <405DD9E2.4030308@pobox.com> <405DE18B.7090505@gmx.net> <405DE2B6.7060003@backtobasicsmgmt.com> <405DF09C.9060804@gmx.net> <405DF48D.90606@gmx.net>
In-Reply-To: <405DF48D.90606@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>- Would an EVMS plugin or a simple script calling dmsetup be the way to
>>>>go? If I go the dmsetup route, is there any chance to get partition
>>>>detection on top of the ATARAID for free (by calling another dm tool)?
>>>
>>>This was posted a while back; I don't know what the status of it being
>>>merged into util-linux is.
>>>
>>>http://lwn.net/Articles/13958/
> 
> Christophe V.: What is the currrent status of your work?
> 
It mutated into kpartx, as I ported the compilation to klibc.
It is functionaly unchanged since that LWN report.

I know it works for partitioned multipath devmaps, partitioned loops, 
partioned md ...

It needs more testing and a lot of integration thinking.

regards,
cvaroqui
