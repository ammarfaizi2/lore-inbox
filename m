Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbVAFO6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVAFO6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 09:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbVAFO47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 09:56:59 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:33114 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262849AbVAFOzL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 09:55:11 -0500
X-Ironport-AV: i="3.88,107,1102312800"; 
   d="scan'208"; a="158398341:sNHT24634004"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Date: Thu, 6 Jan 2005 08:55:06 -0600
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D2F@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Thread-Index: AcTAIAVAVRscS9MSR36xZTS1/gcpSAADEUdwDPQ/CKA=
From: <Tim_T_Murphy@Dell.com>
To: <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jan 2005 14:55:07.0233 (UTC) FILETIME=[B634A510:01C4F3FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for the huge delay since my last post on this, but disabling
low_latency is resulting in dropped characters.

this looks to be exactly what was reported in
http://www.uwsg.iu.edu/hypermail/linux/kernel/0212.0/0412.html

anything i can do to avoid dropping characters without using
low_latency, which still hangs SMP kernels?
thanks,
tim
> -----Original Message-----
> From: Murphy, Tim T 
> Sent: Monday, November 01, 2004 10:07 AM
> To: 'Russell King'
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, 
> but not the
> UP kernel
> 
> 
> > Thanks for testing - I'll be adding this to mainline kernels.
> Thanks Russell.
> I'd be glad to help by testing any further low_latency 
> related patches also.
> Tim
> 
