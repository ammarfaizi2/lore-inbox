Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265962AbUFYBea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265962AbUFYBea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 21:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUFYBea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 21:34:30 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:49679 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S265962AbUFYBe2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 21:34:28 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH] 2.4.27-rc1, nvaudio, i810_audio
Date: Thu, 24 Jun 2004 18:34:26 -0700
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984FE@mail-sc-6-bk.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.4.27-rc1, nvaudio, i810_audio
Thread-Index: AcRaSfCTn7PmFnXcRdC10InmxAj83AACowCw
From: "Andrew Chew" <achew@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Alan Cox" <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From diffs between the forkpoint (2.4.19) and 2.4.27-rc1, and
examination of the nvaudio driver, it doesn't look like the nvaudio
driver inherited any recently fixed bugs from the i810_audio driver.

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Thursday, June 24, 2004 5:18 PM
> To: Andrew Chew
> Cc: Alan Cox; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] 2.4.27-rc1, nvaudio, i810_audio
> 
> 
> On Thu, Jun 24, 2004 at 04:44:59PM -0700, Andrew Chew wrote:
> > This patch adds a new driver under 
> linux/drivers/sound/nvaudio.  The 
> > new driver is heavily derived from the i810_audio driver, 
> but includes 
> > a lot of new work in adding multichannel and spdif support.
> 
> Well, ICH5 and ICH6 (and ICH4?) support this new stuff too.  
> I'm open to a new driver, but maybe rename it to something 
> more vendor-neutral?
> 
> And, does it have the ~11 critical bug fixes that went into 
> i810_audio, to bring it up to version 1.00?
> 
> 	Jeff
> 
> 
> 
> 
