Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271902AbRH2Emr>; Wed, 29 Aug 2001 00:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271903AbRH2Emi>; Wed, 29 Aug 2001 00:42:38 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:23307 "EHLO
	master.aslab.com") by vger.kernel.org with ESMTP id <S271902AbRH2EmY>;
	Wed, 29 Aug 2001 00:42:24 -0400
Date: Tue, 28 Aug 2001 21:29:38 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ross Boylan <RossBoylan@stanfordalumni.org>, <sfr@canb.auug.org.au>,
        Andre Hedrick <andre@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE drive won't come back after power down
In-Reply-To: <E15aoRL-0008V0-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0108261844570.12817-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That is the prefered location; however, setting/writing up hold over code
that will be deleted in 2.5 is silly.  The basics are the non-data
taskfile registers operations.

Thoughts of accepting patches early for taskfile now?

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                    Tel: (510) 857-0055 x103
38875 Cherry Street                          Fax: (510) 857-0010
Newark, CA 94560                             Web: www.aslab.com

On Sun, 26 Aug 2001, Alan Cox wrote:

> > The problem is that the requirements of ACPI is to have a
>
> My PC110 does the same as Ross' machine, and like this box it has no ACPI.
> This isnt an ACPI problem on the boxes I've seen do it.
>
> > You can attempt the noisy reset additions to some versions of hdparm, and
> > then issuing the the checkpower commands until staus is reported as ready,
>
> Any reason you cant do that in kernel space, if an app can do it then
> pm thread code can do it ...
>
> Alan
>


