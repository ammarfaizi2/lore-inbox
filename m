Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUIJQLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUIJQLp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUIJQIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:08:24 -0400
Received: from the-village.bc.nu ([81.2.110.252]:34225 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267549AbUIJQEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:04:36 -0400
Subject: Re: Latest microcode data from Intel.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Bill Davidsen <davidsen@tmr.com>, Tigran Aivazian <tigran@veritas.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4141CCA8.30807@optonline.net>
References: <Pine.LNX.4.44.0409091726010.2713-100000@einstein.homenet>
	 <4141CAAB.4020708@tmr.com>  <4141CCA8.30807@optonline.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094828533.17464.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 16:02:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 16:47, Nathan Bryant wrote:
> Potentially stupid question, how does microcode update interact with CPU 
> hotplug?

You run the microcode update sequence after a CPU is plugged in. That
might be an argument for having user space kick off application use of
hotplugged processors so that some housekeeping can run first.

In the ideal case your BIOS vendor ships you needed BIOS updates to
handle such things and in a sane format.

