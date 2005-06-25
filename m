Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVFYEqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVFYEqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbVFYEqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:46:09 -0400
Received: from [203.171.93.254] ([203.171.93.254]:37060 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261426AbVFYEpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:45:21 -0400
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing
	usable for other purposes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christoph Lameter <christoph@lameter.com>
Cc: Pavel Machek <pavel@ucw.cz>, Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       raybry@engr.sgi.com, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0506242127040.3433@graphe.net>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
	 <20050625025122.GC22393@atrey.karlin.mff.cuni.cz>
	 <Pine.LNX.4.62.0506242127040.3433@graphe.net>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1119674790.4170.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 25 Jun 2005 14:46:30 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-06-25 at 14:31, Christoph Lameter wrote:
> > Previous code had important property: try_to_freeze was optimized away
> > in !CONFIG_PM case. Please keep that.
> 
> Obviously that will not work if we use try_to_freeze for 
> non-power-management purposes. The code from kernel/power/process.c may 
> have to be merged into some other kernel file. kernel/sched.c?

Do you have a non-power-management purpose in mind?

Regards,

Nigel

