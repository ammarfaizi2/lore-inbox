Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVHBKpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVHBKpk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVHBKpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 06:45:40 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:17309 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261359AbVHBKpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 06:45:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jan De Luyck <lkml@kcore.org>
Subject: Re: Linux 2.6.13-rc5 - possible acpi regression?
Date: Tue, 2 Aug 2005 12:50:38 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <200508020843.08030.lkml@kcore.org>
In-Reply-To: <200508020843.08030.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508021250.39136.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2 of August 2005 08:43, Jan De Luyck wrote:
> On Tuesday 02 August 2005 07:07, Linus Torvalds wrote:
> > Ok, one more in the series towards final 2.6.13.
> 
> One thing that seems like a regression: doing
> 
> $ cat /proc/acpi/battery/BAT1/info
> 
> causes a two-second pause and then gives me the information, while in 2.6.12.3 
> that was near-instant.

Please try to ad the ec_polling parameter to the kernel command line and
retest.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
