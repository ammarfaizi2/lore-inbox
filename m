Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWEUJEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWEUJEz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 05:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWEUJEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 05:04:55 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:3504 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751489AbWEUJEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 05:04:54 -0400
Message-ID: <012201c67cb5$7a213800$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org>
Subject: Re: swapper: page allocation failure.
Date: Sun, 21 May 2006 11:03:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Chris Wedgwood" <cw@f00f.org>
To: "Haar J?nos" <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 21, 2006 10:47 AM
Subject: Re: swapper: page allocation failure.


> On Sun, May 21, 2006 at 10:37:00AM +0200, Haar J?nos wrote:
>
> >              total       used       free     shared    buffers
cached
> > Mem:       2073048     893360    1179688          0     829092
19820
> > Low:        893464     868352      25112          0          0
0
> > High:      1179584      25008    1154576          0          0
0
> > -/+ buffers/cache:      44448    2028600
> > Swap:            0          0          0
>
> looks bad for lowmem
>
> what does /proc/meminfo say?

[root@st-0001 vm]# cat /proc/meminfo
MemTotal:      2073048 kB
MemFree:       1179376 kB
Buffers:        829764 kB
Cached:          19896 kB
SwapCached:          0 kB
Active:          15604 kB
Inactive:       837636 kB
HighTotal:     1179584 kB
HighFree:      1154736 kB
LowTotal:       893464 kB
LowFree:         24640 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:           21352 kB
Writeback:           0 kB
Mapped:           7000 kB
Slab:            22612 kB
CommitLimit:   1036524 kB
Committed_AS:    10968 kB
PageTables:        284 kB
VmallocTotal:   114680 kB
VmallocUsed:       308 kB
VmallocChunk:   114036 kB


>
> what about the output from "slabtop -sc" ?

Not installed.
Wich package or where can i find the source? (i use redhat 9.0)

Cheers,
Janos

