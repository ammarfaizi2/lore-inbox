Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbUAHT3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbUAHT3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:29:51 -0500
Received: from [198.70.193.2] ([198.70.193.2]:50522 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S265479AbUAHT2t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:28:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Date: Thu, 8 Jan 2004 11:29:03 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B0598E00@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Thread-Index: AcPWCBdCUX3fJ36nSv6yJLzCNN41GgAFM4/g
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2004 19:29:03.0992 (UTC) FILETIME=[ACEA0780:01C3D61D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 08, 2004 8:54 AM, Christoph Hellwig wrote:
> On Thu, Jan 08, 2004 at 08:47:51AM -0800, Andrew Vasquez wrote:
> > seems to be the proper path.  Just for clarification, given the
> > structure of the driver now (failover completely separated),
> > inclusion of the qla2xxx driver would exclude the following
> > failover files: 
> > 
> > 	qla_fo.c qla_foln.c qla_cfg.c qla_cfgln.c
> > 
> > correct?
> 
>  + qla_inioct.c qla_xioct.c
> 
> and the associated headers for both the ioctl and failover
> code, of course
>

Yes, no IOCTLs...
 
> > Are you proposing to standardize a transport by which a user-space
> > application communicates with a driver (beyond IOCTLs), or, are you
> > suggesting there be some commonality in functional interfaces (i.e.
> > SNIA) for all FC drivers?
> 
> the SNIA HBA-API spec is completely broken.  But we should
> try to support
> a sanitized subset of the spec using the transport class work that's
> currently discussed on linux-scsi.
>

I'll excuse myself from the API debate and take a look at the transport
class infrastructure being proposed.

--
Andrew Vasquez


