Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVCJBZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVCJBZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbVCJBX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:23:26 -0500
Received: from fmr24.intel.com ([143.183.121.16]:21454 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262636AbVCJBBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 20:01:45 -0500
Message-Id: <200503100100.j2A10wg27750@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jesse Barnes'" <jbarnes@engr.sgi.com>, "Andi Kleen" <ak@muc.de>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Wed, 9 Mar 2005 17:00:58 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUlAzlX7DjlMNXJTLa0JE/pkRdAXgACNz7w
In-Reply-To: <200503091552.41450.jbarnes@engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote on Wednesday, March 09, 2005 3:53 PM
> > "Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:
> > > Just to clarify here, these data need to be taken at grain of salt. A
> > > high count in _spin_unlock_* functions do not automatically points to
> > > lock contention.  It's one of the blind spot syndrome with timer based
> > > profile on ia64.  There are some lock contentions in 2.6 kernel that
> > > we are staring at.  Please do not misinterpret the number here.
> >
> > Why don't you use oprofileÂ>? It uses NMIs and can profile "inside"
> > interrupt disabled sections.
>
> Oh, and there are other ways of doing interrupt off profiling by using the
> PMU.  q-tools can do this I think.

Thank you all for the suggestions.  I'm well aware of q-tools and been using
it on and off.  It's just that I don't have any data collected with q-tool
for that particular hardware/software benchmark configuration.  I posted
with whatever data I have.

- Ken


