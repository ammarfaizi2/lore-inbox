Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWBWOF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWBWOF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 09:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWBWOF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 09:05:57 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:908
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751250AbWBWOF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 09:05:57 -0500
Date: Thu, 23 Feb 2006 06:05:45 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.6.15-rt17
Message-ID: <20060223140545.GA30327@gnuppy.monkey.org>
References: <20060221155548.GA30146@elte.hu> <20060223134928.GA30170@gnuppy.monkey.org> <20060223135350.GA20638@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223135350.GA20638@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 02:53:50PM +0100, Ingo Molnar wrote:
> * Bill Huey <billh@gnuppy.monkey.org> wrote:
> > SLAB you say ? What's going on with this error ?
> > undefined reference to `slab_spin_unlock_irqrestore'
> 
> find the fix from S???bastien Dugu??? below.

I recreate the fix since it was obvious and this new version fixes the previous
SLAB related crash in -rt16. Looking good.

bill

