Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVFCSE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVFCSE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVFCSE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:04:57 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:47576 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261426AbVFCSEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:04:50 -0400
Date: Fri, 3 Jun 2005 11:04:36 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Andreas Schwab <schwab@suse.de>
Cc: geert@linux-m68k.org, joern@wohnheim.fh-wedel.de, xiao@unice.fr,
       linux-kernel@vger.kernel.org
Subject: Re: Suggestion on "int len" sanity
Message-Id: <20050603110436.3f801c65.rdunlap@xenotime.net>
In-Reply-To: <jed5r3eca8.fsf@sykes.suse.de>
References: <429EB537.4060305@unice.fr>
	<20050602084840.GA32519@wohnheim.fh-wedel.de>
	<Pine.LNX.4.62.0506031143100.16362@numbat.sonytel.be>
	<jer7fjeiae.fsf@sykes.suse.de>
	<Pine.LNX.4.62.0506031443000.16362@numbat.sonytel.be>
	<jed5r3eca8.fsf@sykes.suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jun 2005 16:38:07 +0200 Andreas Schwab wrote:

| Geert Uytterhoeven <geert@linux-m68k.org> writes:
| 
| > On Fri, 3 Jun 2005, Andreas Schwab wrote:
| >> Geert Uytterhoeven <geert@linux-m68k.org> writes:
| >> 
| >> >> 	union {
| >> >> 		unsigned len;
| >> >                 ^^^^^^^^
| >> > Plain unsigned is deprecated.
| >> 
| >> Says who?
| >
| > Sorry, forgot to add the
| > `Signed-Off-by: Geert Uytterhoeven <geert@linux-m68k.org>' line :-)
| 
| Who deprecated it?

Not technically deprecated, just undesirable in the kernel sources.


---
~Randy
