Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270931AbTG2CKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271224AbTG2CKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:10:33 -0400
Received: from fmr05.intel.com ([134.134.136.6]:5580 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S270931AbTG2CKc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:10:32 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] Remove module reference counting. 
Date: Mon, 28 Jul 2003 19:10:30 -0700
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE3A9C4D@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Remove module reference counting. 
Thread-Index: AcNVdgYQk4PYYYMIR1+lmRcSDcFPBgAAGU/A
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Rusty Russell" <rusty@rustcorp.com.au>,
       "Rahul Karnik" <rahul@genebrew.com>
Cc: <davem@redhat.com>, <arjanv@redhat.com>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jul 2003 02:10:30.0538 (UTC) FILETIME=[95DE46A0:01C35576]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Rusty Russell [mailto:rusty@rustcorp.com.au]

> > Last but not least weren't we moving towards a more modular kernel with
> > early userspace loading things from initrd as needed? Removing existing
> > module functionality, however broken it may be, seems to me a step
> > backward in this regard.
> 
> Not really.  Adding modules is required.  Removing them is a more
> dubious goal, and if we didn't already have it, I know we'd balk at
> doing it.

Can I add that it is really desirable to remove modules when developing
drivers? [and so to avoid reboots when loading new code?].

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
