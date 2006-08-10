Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161289AbWHJO4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161289AbWHJO4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161297AbWHJO4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:56:06 -0400
Received: from mail0.lsil.com ([147.145.40.20]:14487 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1161289AbWHJO4E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:56:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/3] scsi : megaraid_{mm,mbox}: 64-bit DMA capabilitychecker
Date: Thu, 10 Aug 2006 08:55:19 -0600
Message-ID: <890BF3111FB9484E9526987D912B261932E331@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/3] scsi : megaraid_{mm,mbox}: 64-bit DMA capabilitychecker
Thread-Index: AcaycpVVJKvL6lmwSUqdzDRDCcUADgKGTrMg
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: <vvs@sw.ru>, <akpm@osdl.org>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>
X-OriginalArrivalTime: 10 Aug 2006 14:55:20.0003 (UTC) FILETIME=[FFD1F130:01C6BC8C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Friday, July 28, 2006 2:21 PM, James Bottomley wrote:
> I'll fix it up this time, but in future could you trailing whitespace
> check your patches? (git will do this for you).
I have one clarification.
When will be these patches merged into scsi-misc tree?
I've seen them merged into -mm tree.
I have another patch to create, which tree should I against for it?

Seokmann

> -----Original Message-----
> From: James Bottomley [mailto:James.Bottomley@SteelEye.com] 
> Sent: Friday, July 28, 2006 2:21 PM
> To: Ju, Seokmann
> Cc: vvs@sw.ru; akpm@osdl.org; linux-scsi@vger.kernel.org; 
> linux-kernel@vger.kernel.org; Patro, Sumant; Yang, Bo
> Subject: Re: [PATCH 1/3] scsi : megaraid_{mm,mbox}: 64-bit 
> DMA capabilitychecker
> 
> On Tue, 2006-07-25 at 08:44 -0600, Ju, Seokmann wrote:
> > This patch contains 
> > - a fix for 64-bit DMA capability check in 
> megaraid_{mm,mbox} driver.
> > - includes changes (going back to 32-bit DMA mask if 64-bit DMA mask
> > failes) suggested by James with previous patch.
> > - addition of SATA 150-4/6 as commented by Vasily Averin.
> 
> Warning: trailing whitespace in lines 885,889 of
> drivers/scsi/megaraid/megaraid_mbox.c
> Warning: trailing whitespace in lines
> 13,15,16,19,21,22,26,27,29,31,33,37,39,46 of
> Documentation/scsi/ChangeLog.megaraid
> 
> I'll fix it up this time, but in future could you trailing whitespace
> check your patches? (git will do this for you).
> 
> Also, when you do a git workflow, the body of the email becomes the
> commit message, so things like this
> 
> > This is a third patch which follows prevous two patches ([PATCH 1/3]
> > and
> > [PATCH 2/3]).
> 
> while no doubt being useful to the members of linux-scsi who are
> actually unable to count aren't actually useful in commit messages.
> 
> James
> 
> 
> 
