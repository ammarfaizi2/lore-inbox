Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAPRb4>; Tue, 16 Jan 2001 12:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbRAPRbq>; Tue, 16 Jan 2001 12:31:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:22456 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129406AbRAPRbe>; Tue, 16 Jan 2001 12:31:34 -0500
Importance: Normal
To: linux-kernel@vger.kernel.org, Venkatesh Ramamurthy <Venkateshr@ami.com>
Subject: RE: Linux not adhering to BIOS Drive boot order?
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF0BCB3D0B.CD3301DB-ON872569D6.005E41A3@LocalDomain>
From: "Bryan Henderson" <hbryan@us.ibm.com>
Date: Tue, 16 Jan 2001 09:30:55 -0800
X-MIMETrack: Serialize by Router on D03NM088/03/M/IBM(Release 5.0.4a |July 24, 2000) at
 01/16/2001 10:31:30 AM,
	Serialize complete at 01/16/2001 10:31:30 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If we can truly go for label based mounting
>and lilo'ing this would solve the problem.

>From a layering point of view, it makes a lot more sense to
me for the label (or signature or whatever) for this purpose 
to be in the partition table than inside the filesystem.  The 
parts of the system that assign devices their identities already 
know about that part of the disk.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
