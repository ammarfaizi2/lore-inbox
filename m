Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316079AbSEOO16>; Wed, 15 May 2002 10:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316083AbSEOO15>; Wed, 15 May 2002 10:27:57 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:48283 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S316079AbSEOO14>; Wed, 15 May 2002 10:27:56 -0400
From: "Ashok Raj" <ashokr2@attbi.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Pete Zaitcev" <zaitcev@redhat.com>
Cc: <Tony.P.Lee@nokia.com>, <lmb@suse.de>, <woody@co.intel.com>,
        <linux-kernel@vger.kernel.org>, <zaitcev@redhat.com>
Subject: RE: InfiniBand BOF @ LSM - topics of interest
Date: Wed, 15 May 2002 07:27:36 -0700
Message-ID: <PPENJLMFIMGBGDDHEPBBKEKNDAAA.ashokr2@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E177wy8-0001hK-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

InfiniBand specifications provides tools to implement QoS.

Service Level (SL) and Virtual Lane (VL) managed by the SM determines how
the SL->VL mapping is performed these attributes are carried in the local
routing headers when a node sources the packet to the fabric.

The SL is not modified when the packet crosses subnets. IB spec has more
details on how these could be used. There is a separate congestion control
work group in IBTA that is trying to address these issue, but i have not see
that very active. Possibly since the update to 1.0a is due in very short
time.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
Sent: Wednesday, May 15, 2002 4:29 AM
To: Pete Zaitcev
Cc: Alan Cox; Tony.P.Lee@nokia.com; lmb@suse.de; woody@co.intel.com;
linux-kernel@vger.kernel.org; zaitcev@redhat.com
Subject: Re: InfiniBand BOF @ LSM - topics of interest


> The thing about Infiniband is that its scope is so great.
> If you consider Infiniband was only a glorified PCI with serial
> connector, the congestion control is not an issue. Credits

Congestion control is always an issue 8

> are quite sufficient to provide per link flow control, and
> everything would work nicely with a couple of switches.
> Such was the original plan, anyways, but somehow cluster
> ninjas managed to hijack the spec and we have the rabid
> overengineering running amok. In fact, they ran so far
> that Intel jumped ship and created PCI Express, and we
> have discussions about congestion control. Sad, really...

My interest is in the question "does infiniband have usable congestion
control for tcp/clustering/networking". I don't actually care if it doesn't
and I'd rather have most congestion control in software anyway.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

