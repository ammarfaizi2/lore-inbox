Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUEGWA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUEGWA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 18:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUEGWA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 18:00:28 -0400
Received: from fmr03.intel.com ([143.183.121.5]:58334 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263802AbUEGWAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 18:00:24 -0400
Message-Id: <200405072200.i47M0AF00868@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Cache queue_congestion_on/off_threshold
Date: Fri, 7 May 2004 15:00:10 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQ0FzE+87kn5u68RLiIcctTfFmIfwAZvcuQ
In-Reply-To: <20040507093921.GD21109@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Jens Axboe wrote on Friday, May 07, 2004 2:39 AM
> On Thu, May 06 2004, Chen, Kenneth W wrote:
> > (3) can we allocate request structure up front in __make_request?
> >     For I/O that cannot be merged, the elevator code executes twice
> >     in __make_request.
> >
>
> Actually, with the good working batching we might get away with killing
> freereq completely. Have you tested that (if not, could you?)

Sorry, I'm clueless on "good working batching".  If you could please give
me some pointers, I will definitely test it.

- Ken


