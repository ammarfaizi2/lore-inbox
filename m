Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266824AbUFYSBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUFYSBM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266826AbUFYSBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:01:12 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:41231 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S266824AbUFYSBJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:01:09 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH] 2.4.27-rc1, nvaudio, i810_audio
Date: Fri, 25 Jun 2004 11:01:08 -0700
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984FF@mail-sc-6-bk.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.4.27-rc1, nvaudio, i810_audio
Thread-Index: AcRaSfCTn7PmFnXcRdC10InmxAj83AAlBZUA
From: "Andrew Chew" <achew@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Alan Cox" <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Well, ICH5 and ICH6 (and ICH4?) support this new stuff too.  
> I'm open to a new driver, but maybe rename it to something 
> more vendor-neutral?
It looks like the ICH5/6's register map for spdif is different, so it
would require some work to get them working with the nvaudio driver that
I submitted.

> And, does it have the ~11 critical bug fixes that went into 
> i810_audio, to bring it up to version 1.00?
I just realized that you were referring to the DRIVER_VERSION macro in
the driver.  Yes, since this is a first submission of the driver, let's
call it 0.1 instead.  1.0 is definitely not appropriate.
