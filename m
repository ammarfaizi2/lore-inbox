Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUHWMM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUHWMM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 08:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUHWMM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 08:12:28 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:23556 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263770AbUHWMMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 08:12:24 -0400
Date: Mon, 23 Aug 2004 14:12:21 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/14] kexec: apic-virtwire-on-shutdown.i386.patch
In-Reply-To: <m1vffd667r.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58L.0408231411480.19572@blysk.ds.pg.gda.pl>
References: <m1vffd667r.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Eric W. Biederman wrote:

> Restore the local apic to virtual wire mode on reboot.

 Hmm, perhaps you should check for the through-I/O-APIC Virtual Wire mode.
I've seen reports from such systems in the past.  They may not necessarily
handle the through-Local-APIC mode correctly.

  Maciej
