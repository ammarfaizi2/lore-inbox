Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262899AbSJAWfv>; Tue, 1 Oct 2002 18:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262900AbSJAWfv>; Tue, 1 Oct 2002 18:35:51 -0400
Received: from fmr06.intel.com ([134.134.136.7]:18903 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S262899AbSJAWfu>; Tue, 1 Oct 2002 18:35:50 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEE9@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@ucw.cz>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: RE: ACPI sleep: stupid bug reintroduced
Date: Tue, 1 Oct 2002 15:41:03 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@ucw.cz] 
> There's extremely stupid bug in sleep.c -- it will only alow user to
> enter *unsupported* states. What's even worse that I remember fixing
> that once before, and *it was merged to mainline*.

Cough cough Pat... ;-)

It's (re-)fixed in my bk tree already. Didn't have this bit at the end so
I'll apply that.

Regards -- Andy

> +#else
> +	return_VALUE(-ENODEV);
>  #endif
