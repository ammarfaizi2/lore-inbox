Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVEPUK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVEPUK4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVEPUHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:07:22 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.143]:49937 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S261803AbVEPUGW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:06:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Broken nForce2 IDE module loading via hotplug
Date: Mon, 16 May 2005 13:06:17 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00604C7BE@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Broken nForce2 IDE module loading via hotplug
thread-index: AcVaUbEMOSEE3FXLSfWYDUU2jlk6igAAKp+g
From: "Andrew Chew" <AChew@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Juerg Billeter" <juerg@paldo.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 May 2005 20:06:18.0007 (UTC) FILETIME=[B88E2A70:01C55A52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, it occurred to me that it would be better if the determination
to use the generic entry can be run-time specified (via a kernel option
flag, for example).  All the kernel config option accomplishes is a
cleaner way to disable the generic entry at compile time.

In any case, it'd be interesting to figure out the EXACT root of the
problem.  Let me spend a few days looking into it.

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com] 
Sent: Monday, May 16, 2005 12:59 PM
To: Andrew Chew
Cc: Juerg Billeter; linux-kernel@vger.kernel.org
Subject: Re: Broken nForce2 IDE module loading via hotplug

Andrew Chew wrote:
> I think the kernel config option to disable the generic entry is a
good
> idea.  Jeff, want me to submit a patch for this? 

Please.

	Jeff



