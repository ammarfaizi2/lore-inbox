Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbVJGTR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbVJGTR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 15:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030495AbVJGTR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 15:17:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32270 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030479AbVJGTRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 15:17:25 -0400
Date: Fri, 7 Oct 2005 20:17:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] pcmcia-shutdown-fix.patch
Message-ID: <20051007191712.GB22608@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org,
	Steven Rostedt <rostedt@goodmis.org>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu> <20051002151817.GA7228@elte.hu> <5bdc1c8b0510020842p6035b4c0ibbe9aaa76789187d@mail.gmail.com> <5bdc1c8b0510021225y951caf3p3240a05dd2d0247c@mail.gmail.com> <Pine.LNX.4.58.0510061308290.973@localhost.localdomain> <20051007110914.GA30873@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007110914.GA30873@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 01:09:14PM +0200, Ingo Molnar wrote:
> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Ingo, here's the patch.  This should probably go upstream too since it 
> > can happen there too.  The pccardd thread has a race in it that it can 
> > shutdown in the TASK_INTERRUPTIBLE state.  Here's the fix.
> 
> ah, certainly makes sense. Dominik, does it look good to you too? Patch 
> below is for upstream.

Looks correct to me (I'm the author of this code.)  Since it's
a bug fix, please send it upstream ASAP.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
