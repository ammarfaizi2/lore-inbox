Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278214AbRJRXoh>; Thu, 18 Oct 2001 19:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278216AbRJRXo0>; Thu, 18 Oct 2001 19:44:26 -0400
Received: from adsl-216-102-163-254.dsl.snfc21.pacbell.net ([216.102.163.254]:29352
	"EHLO windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S278214AbRJRXoR>; Thu, 18 Oct 2001 19:44:17 -0400
Date: Thu, 18 Oct 2001 16:41:54 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: jimmy <x55k@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: UNABLE TO BOOT WITH 2nd SCSI DRIVE
In-Reply-To: <20011018233359.2084.qmail@web20206.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0110181640150.7353-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Oct 2001, jimmy wrote:

> Hello,
>
> I hope you can shed a light to my problem. The server
> works just fine with a single SCSI drive.
> Unfortunately, when we add the 2nd SCSI drive, the
> system does not boot.

You've made sure that your original drive (the IBM) has the lowest ID
number on the bus?

> P3 866 MHz, BX M/b, 512 MB Ram, 9.1 GB SCSI IBM hd.
> (works fine)
> 2nd HD: Cheetah 15000 RPM 36 GB hd (gives problem when
> added to the system)

Looks like you put a UW drive (the IBM) on the same u160/lvd channel as a
u160/lvd drive (the Seagate).  Should work fine but this is where I would
focus my suspicion.

Note that a UW bus needs to be really, really short.  How long is your
cabling end-to-end?

-jwb

