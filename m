Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270256AbTHGPNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270244AbTHGPMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:12:43 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:62474
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S270489AbTHGPL7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:11:59 -0400
Subject: Re: [BROKEN PATCH] syscalls leak data via registers?
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030807103043.GB211@elf.ucw.cz>
References: <1059815183.18860.55.camel@ixodes.goop.org>
	 <20030807103043.GB211@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1060269116.20515.14.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 07 Aug 2003 08:11:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-07 at 03:30, Pavel Machek wrote:
> I believe userspace depends on registers to be preserved over system
> call, except for eax.

That's what I was wondering.  Does it?  Is that a documented part of the
syscall interface?

>  So what you found is not only security problem,
> but also crasher bug.

In these sense that it crashes userspace?

	J

