Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265918AbTL3UcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbTL3UcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:32:13 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:64411 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265918AbTL3UcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:32:10 -0500
Date: Tue, 30 Dec 2003 21:31:47 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dom <binary1230@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: KERNEL BUG: 2.4.22 processes occasionally segfault, kernel crashes, machine reboots
Message-ID: <20031230203147.GA28446@wohnheim.fh-wedel.de>
References: <20031230190822.88961.qmail@web40210.mail.yahoo.com> <20031230192108.GW1882@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031230192108.GW1882@matchmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 December 2003 11:21:08 -0800, Mike Fedyk wrote:
> On Tue, Dec 30, 2003 at 11:08:22AM -0800, Dom wrote:
> > [1.] (seemingly random?) processes occasionally
> > segfault, kernel crashes, machine reboots
> 
> I'd suggest you run memtest86 on it ASAP since zap_page_range is a very
> often used function in the kernel, and very unlikely to have bugs in it, and
> more likely to find hardware problems.
> 
> Also check your:
>  o cooling
>  o power supply
>  o cables

Or try to reproduce the same problems on a different machine.  If you
can - ugly kernel bug.  If not - borken hardware.  I suspect you
can't.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
