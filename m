Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbTD0NqW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 09:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264622AbTD0NqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 09:46:22 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:51727 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S264002AbTD0NqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 09:46:21 -0400
Date: Sun, 27 Apr 2003 15:58:23 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] An generic subarchitecture for 2.5.68
In-Reply-To: <20030427134217.GA1287@averell>
Message-ID: <Pine.LNX.4.44.0304271555530.5042-100000@serv>
References: <20030427012238.GA13997@averell> <20030426231147.69efb07d.akpm@digeo.com>
 <20030427134217.GA1287@averell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 27 Apr 2003, Andi Kleen wrote:

> Really BIGSMP, SUMMIT, GENERICARCH need to be only enabled with
> SMP is enabled.
> 
> But Kconfig seems to ignore depends inside choice. Roman, any ideas
> how to fix that?

What did you try? E.g. this works fine here:

config X86_BIGSMP
	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
	depends on SMP
	help
	...

bye, Roman

