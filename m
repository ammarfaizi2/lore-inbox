Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUESLt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUESLt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUESLt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:49:57 -0400
Received: from fmr05.intel.com ([134.134.136.6]:22933 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263664AbUESLtz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:49:55 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] [RESEND] 2.4.27-pre3  backout acpi_fixed_pwr_button
Date: Wed, 19 May 2004 19:49:10 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8404623067@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [RESEND] 2.4.27-pre3  backout acpi_fixed_pwr_button
Thread-Index: AcQ9j5OXWcVhXzBQTKG7Ze9Y4OaqHgABwc9g
From: "Yu, Luming" <luming.yu@intel.com>
To: "O.Sezer" <sezero@superonline.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: "Brown, Len" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 May 2004 11:49:11.0423 (UTC) FILETIME=[4CFD20F0:01C43D97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your catching. As far as I know, Len has done it in his bk tree. And I think it will be pushed into baseline soon.

Thanks,
Luming



>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of O.Sezer
>Sent: Wednesday, May 19, 2004 6:29 PM
>To: Marcelo Tosatti
>Cc: Brown, Len; linux-kernel@vger.kernel.org
>Subject: [PATCH] [RESEND] 2.4.27-pre3 backout acpi_fixed_pwr_button
>
>Marcelo:
>
>2.4.27-pre3 still seems to have the acpi_fixed_pwr_button and
>acpi_fixed_sleep_button changes in it, which oopses for me
>upon module unload. Sergey Vlasov's response to my report is
>attached. The original oops report is here:
>http://marc.theaimsgroup.com/?l=linux-kernel&m=108405180820535&w=2
>
>If you don't have another fix for it, please apply the included
>patch in order to back that out.
>
>Regards,
>Özkan Sezer
>
