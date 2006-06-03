Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWFCIRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWFCIRV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 04:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWFCIRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 04:17:20 -0400
Received: from mga03.intel.com ([143.182.124.21]:51840 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030302AbWFCIRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 04:17:19 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="45452807:sNHT14256221"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>
Cc: <nickpiggin@yahoo.com.au>, <mason@suse.com>, <kernel@kolivas.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch] fix smt nice lock contention and optimization
Date: Sat, 3 Jun 2006 01:17:19 -0700
Message-ID: <000901c686e6$225abd90$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaG5Ud+07mb9SMoS1KO5N4AAoQttQAAEZaA
In-Reply-To: <20060603011107.4c6de627.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Saturday, June 03, 2006 1:11 AM
> Ingo Molnar <mingo@elte.hu> wrote:
> > looks really good now to me.
> > 
> >  Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > 
> > lets try it in -mm?
> > 
> 
> Yup.  I redid Ken's patch against mainline and them mangled
> lock-validator-special-locking-schedc.patch to suit.

Hmm, wish I knew this beforehand, so that I won't spend extra 1/2
hour to port the patch to -mm and only to have you convert it back
to mainline. I could just post the version I originally had against
the mainline.

- Ken
