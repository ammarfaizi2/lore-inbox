Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbUL3CLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbUL3CLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 21:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbUL3CLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 21:11:46 -0500
Received: from fmr17.intel.com ([134.134.136.16]:38105 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261508AbUL3CLf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 21:11:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] SATA support for Intel ICH7 - 2.6.10
Date: Wed, 29 Dec 2004 18:11:20 -0800
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F502AE9FAD@orsmsx410>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] SATA support for Intel ICH7 - 2.6.10
Thread-Index: AcTuDZVlHr79Pvv8Ri6hJN1fvLthYQABxVcg
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: "Ulrich Drepper" <drepper@gmail.com>
Cc: "Jeff Garzik" <jgarzik@redhat.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Dec 2004 02:11:22.0462 (UTC) FILETIME=[DB9F3FE0:01C4EE14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ulrich!

I will edit and resubmit the patch with &&.

Jason


>-----Original Message-----
>From: Ulrich Drepper [mailto:drepper@gmail.com]
>Sent: Wednesday, December 29, 2004 5:19 PM
>To: Gaston, Jason D
>Cc: Jeff Garzik; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] SATA support for Intel ICH7 - 2.6.10
>
>On Wed, 29 Dec 2004 16:13:41 -0800, Gaston, Jason D
><jason.d.gaston@intel.com> wrote:
>>         } else {
>> -               WARN_ON(ich != 6);
>> +               WARN_ON((ich != 6) || (ich != 7));
>
>This cannot be right.  Every number is either != 6 or != 7.  You want
&&.
