Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265021AbTFLXhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbTFLXhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:37:38 -0400
Received: from air-2.osdl.org ([65.172.181.6]:21683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265021AbTFLXhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:37:36 -0400
Date: Thu, 12 Jun 2003 16:52:58 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Paul Mackerras <paulus@samba.org>
cc: Robert Love <rml@tech9.net>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@digeo.com>, <sdake@mvista.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <16105.3943.510055.309447@nanango.paulus.ozlabs.org>
Message-ID: <Pine.LNX.4.44.0306121651170.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You can't do atomic_inc_and_read on 386.  You can on cpus that have
> cmpxchg (e.g. later x86).  You can also on machines with load-locked
> and store-conditional instructions (alpha, ppc, probably most other
> RISCs).

Damn, so be it. Ho hum, back to the spinlock I go..


	-pat

