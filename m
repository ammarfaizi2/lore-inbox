Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbWCPAeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWCPAeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWCPAeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:34:08 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:36644 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S932622AbWCPAeH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:34:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Date: Wed, 15 Mar 2006 16:33:39 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00E48CD06@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Thread-Index: AcZIgrKdMQFSfaIPTAOMkUyX9bfFVQADa5fA
From: "Allen Martin" <AMartin@nvidia.com>
To: "Jeff Garzik" <jeff@garzik.org>,
       "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>,
       "Andi Kleen" <ak@suse.de>, "Jason Baron" <jbaron@redhat.com>,
       <linux-kernel@vger.kernel.org>, "john stultz" <johnstul@us.ibm.com>
X-OriginalArrivalTime: 16 Mar 2006 00:33:39.0815 (UTC) FILETIME=[45620F70:01C64891]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>well, it's a PIO inb() op i think, and could thus in theory 
> trigger SMM 
> >>BIOS code.
> > 
> >  
> > Is there any easy way to disable more SMM stuff than "noacpi"?
> 
> It's unlikely you can disable SMM stuff even with noacpi...
> 

There should be no SMI traps on ATA BARs.  At least we don't put any in
our reference BIOS and I can't imagine why any of the BIOS vendors or
motherboard mfgs would add any.

-Allen
