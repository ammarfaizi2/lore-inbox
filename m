Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267910AbUG2PTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267910AbUG2PTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268167AbUG2PT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:19:29 -0400
Received: from the-village.bc.nu ([81.2.110.252]:5020 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267910AbUG2PCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:02:47 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com, Jesse Barnes <jbarnes@engr.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m14qnr62hd.fsf@ebiederm.dsl.xmission.com>
References: <16734.1090513167@ocs3.ocs.com.au>
	 <200407280903.37860.jbarnes@engr.sgi.com>
	 <m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
	 <200407281106.17626.jbarnes@engr.sgi.com>
	 <20040728124405.1a934bec.akpm@osdl.org>
	 <m1pt6f681y.fsf@ebiederm.dsl.xmission.com>
	 <1091055192.31923.1.camel@localhost.localdomain>
	 <m14qnr62hd.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091109602.851.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 15:00:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-07-29 at 02:12, Eric W. Biederman wrote:
> Or those devices that hang the machine when you clear it.

There are none. Its required by the PCI spec and used by BIOS vendors
during the boot sequence. So its a *tested* approach.

> And there is the fact that the pci configuration access methods
> are frequently BIOS calls.

You will be running bios code on some systems every time you read
the cmos clock, every time you touch pci config space, every time
you hit a key, even in your new kernel boot up path - whats your
point

> So I do see just clearing the master bit on each PCI devices to
> as dangerous as calling the shutdown methods.

Then we violently disagree

