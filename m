Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbUCYTFM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUCYTFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:05:12 -0500
Received: from fmr03.intel.com ([143.183.121.5]:38813 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263564AbUCYTFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:05:07 -0500
Message-Id: <200403251904.i2PJ4iF25729@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Pavel Machek'" <pavel@ucw.cz>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: add lowpower_idle sysctl
Date: Thu, 25 Mar 2004 11:04:44 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQRhifG+uEt7tcTT8WvB0P5F+ZMBwBFVxIA
In-Reply-To: <20040324095422.GA241@elf.ucw.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Pavel Machek wrote on Wed, March 24, 2004 1:54 AM
> > +extern int idle_mode;
> > +
> > +#define IDLE_NOOP	0
> > +#define IDLE_HALT	1
> > +#define IDLE_POLL	2
> > +#define IDLE_ACPI	3
> >
>
> How is idle_noop different from idle_poll?

I was thinking idle_noop truly does nothing at all, versus idle_poll
which optimize cross cpu wakeup.


