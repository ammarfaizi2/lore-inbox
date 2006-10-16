Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWJPRuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWJPRuu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 13:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWJPRuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 13:50:50 -0400
Received: from mail0.lsil.com ([147.145.40.20]:6846 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1161039AbWJPRut convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 13:50:49 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Frequent RESETs with 2.6.16 megaraid_sas
Date: Mon, 16 Oct 2006 11:50:45 -0600
Message-ID: <0631C836DBF79F42B5A60C8C8D4E82297502D6@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Frequent RESETs with 2.6.16 megaraid_sas
Thread-Index: AcbxSUnXcuWgzgWcQJyhlFfHYDuFrwAAda2w
From: "Patro, Sumant" <Sumant.Patro@lsi.com>
To: "Andrew Moise" <chops@demiurgestudios.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Oct 2006 17:50:46.0956 (UTC) FILETIME=[9C0CBEC0:01C6F14B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The line you picked is a critical bug fix. However, the patch also
contains code to handle new FW states. I would recommend you to apply
the whole patch.

Regards,
Sumant 

-----Original Message-----
From: Andrew Moise [mailto:chops@demiurgestudios.com] 
Sent: Monday, October 16, 2006 10:34 AM
To: Patro, Sumant
Cc: linux-kernel@vger.kernel.org
Subject: Re: Frequent RESETs with 2.6.16 megaraid_sas

On 10/16/06, Patro, Sumant <Sumant.Patro@lsi.com> wrote:
>         The patch that you have mentioned is a critical bug fix and 
> must be applied.

  Okay, thanks.  Is it just the one-liner I picked out that's critical,
or is the whole "[Patch 1/6] megaraid_sas: FW transition and q size
changes" a critical fix?
  Please CC replies to me, as I'm not on the list.  Thanks.
