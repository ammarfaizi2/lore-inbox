Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWA3WgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWA3WgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWA3WgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:36:12 -0500
Received: from mail0.lsil.com ([147.145.40.20]:63637 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1030195AbWA3WgK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:36:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 3/3] megaraid_sas: support for 1078 type controller added
Date: Mon, 30 Jan 2006 15:35:58 -0700
Message-ID: <9738BCBE884FDB42801FAD8A7769C265539345@NAMAIL1.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/3] megaraid_sas: support for 1078 type controller added
Thread-Index: AcYh63GGL6+BapisS4udLTQwRgUHAQD9rpNwAALMU0A=
From: "Kolli, Neela" <Neela.Kolli@lsil.com>
To: "Moore, Eric" <Eric.Moore@lsil.com>,
       "Patro, Sumant" <Sumant.Patro@engenio.com>, <hch@lst.de>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       <James.Bottomley@SteelEye.com>
Cc: "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>,
       "Doelfel, Hardy" <Hardy.Doelfel@engenio.com>
X-OriginalArrivalTime: 30 Jan 2006 22:35:59.0474 (UTC) FILETIME=[8AEA8520:01C625ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We will be sending a new patch that takes care of this problem.

Thanks,
Neela Syam Kolli.


-----Original Message-----
From: Moore, Eric 
Sent: Monday, January 30, 2006 4:29 PM
To: Patro, Sumant; hch@lst.de; linux-kernel@vger.kernel.org;
linux-scsi@vger.kernel.org; James.Bottomley@SteelEye.com
Cc: Bagalkote, Sreenivas; Kolli, Neela; Yang, Bo; Doelfel, Hardy
Subject: RE: [PATCH 3/3] megaraid_sas: support for 1078 type controller
added

On Wednesday, January 25, 2006 1:06 PM, Sumant Patro wrote:

> 
> Hello All,
> 
> 	This patch adds support for 1078 type controller 
> (device id : 0x62).
> Patch is made against the latest git snapshot of scsi-misc-2.6 tree.
> 
> 	Please review it and all comments are appreciated.
> 
> Thanks,
> 

James - NACK this patch.
I noticed you have picked up this patch in your scsi-rc-fixes stream.
http://www.kernel.org/pub/linux/kernel/people/jejb/scsi-rc-fixes-2.6.cha
ngelog

There is a mistake with this patch.  This SAS1078 device id (0x62) is
the same
id we are claiming for our fusion drivers. Our device ID is 0x62.  You
can see
that at this link: http://pci-ids.ucw.cz/iii/?i=10000062.  I haven't got
around
to it, but I plan to post support for that soon.

A different version of SAS1078 is being manufactured by the megaraid
group.  
Neela Syam Kolli is aware of this issue, and I believe they are working
out the details, 
and will be posting a patch to solve this.

Can this patch be backed out if its not fixed before 2.6.16 kernel is
released.

Eric Moore



