Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUCVLsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 06:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUCVLsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 06:48:13 -0500
Received: from pop.gmx.net ([213.165.64.20]:25231 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261888AbUCVLsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 06:48:11 -0500
X-Authenticated: #21910825
Message-ID: <405ED218.8080003@gmx.net>
Date: Mon, 22 Mar 2004 12:46:32 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: christophe varoqui <christophe.varoqui@free.fr>
CC: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Device mapper devel list <dm-devel@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Thomas Horsten <thomas@horsten.com>,
       Christophe Saout <christophe@saout.de>
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <405DD9E2.4030308@pobox.com> <405DE18B.7090505@gmx.net> <405DE2B6.7060003@backtobasicsmgmt.com> <405DF09C.9060804@gmx.net> <405DF48D.90606@gmx.net> <405DF8CD.4090608@free.fr>
In-Reply-To: <405DF8CD.4090608@free.fr>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe varoqui wrote:
>>>>> - Would an EVMS plugin or a simple script calling dmsetup be the
>>>>> way to
>>>>> go? If I go the dmsetup route, is there any chance to get partition
>>>>> detection on top of the ATARAID for free (by calling another dm tool)?
>>>>
>>>>
>>>> This was posted a while back; I don't know what the status of it being
>>>> merged into util-linux is.
>>>>
>>>> http://lwn.net/Articles/13958/
>>
>>
>> Christophe V.: What is the currrent status of your work?
>>
> It mutated into kpartx, as I ported the compilation to klibc.
> It is functionaly unchanged since that LWN report.
> 
> I know it works for partitioned multipath devmaps, partitioned loops,
> partioned md ...
> 
> It needs more testing and a lot of integration thinking.

Oh, you will get a lot of testing once I use kpartx to handle partitions
on top of ataraid. I'm aiming for a working solution at the end of this week.


Regards,
Carl-Daniel

