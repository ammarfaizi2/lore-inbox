Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751608AbWIUVhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWIUVhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWIUVhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:37:34 -0400
Received: from mail0.lsil.com ([147.145.40.20]:1010 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751603AbWIUVhd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:37:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Patch 4/7] megaraid_sas: adds reboot handler
Date: Thu, 21 Sep 2006 15:36:58 -0600
Message-ID: <0631C836DBF79F42B5A60C8C8D4E82296DF2C9@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch 4/7] megaraid_sas: adds reboot handler
Thread-Index: Acbdc1M3YLCrrIfeR1mN1X+tH9ID+QAUrZkw
From: "Patro, Sumant" <Sumant.Patro@lsil.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <James.Bottomley@SteelEye.com>, <linux-scsi@vger.kernel.org>,
       <akpm@osdl.org>, <hch@lst.de>, <linux-kernel@vger.kernel.org>,
       "Kolli, Neela" <Neela.Kolli@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>
X-OriginalArrivalTime: 21 Sep 2006 21:36:59.0100 (UTC) FILETIME=[1159D1C0:01C6DDC6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree.

Regards,
Sumant

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org] 
Sent: Thursday, September 21, 2006 4:44 AM
To: Patro, Sumant
Cc: James.Bottomley@SteelEye.com; linux-scsi@vger.kernel.org;
akpm@osdl.org; hch@lst.de; linux-kernel@vger.kernel.org; Kolli, Neela;
Yang, Bo
Subject: Re: [Patch 4/7] megaraid_sas: adds reboot handler

On Wed, Sep 20, 2006 at 07:02:51PM -0700, Sumant Patro wrote:
> This patch adds handler to get reboot notification and fires flush
command from 
> the reboot notification handler. 

NACK, this should be handled by the PCI driver ->shutdown method
instead.

