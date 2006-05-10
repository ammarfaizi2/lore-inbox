Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWEJMrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWEJMrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 08:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWEJMrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 08:47:14 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:4203 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S964943AbWEJMrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 08:47:13 -0400
Date: Wed, 10 May 2006 15:46:00 +0300
From: Gleb Natapov <gleb@minantech.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document futex PI design
Message-ID: <20060510124600.GN5319@minantech.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com> <Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com> <Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com> <20060510101729.GB31504@elte.hu> <Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com>
X-OriginalArrivalTime: 10 May 2006 12:47:12.0264 (UTC) FILETIME=[DB911080:01C6742F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 06:59:49AM -0400, Steven Rostedt wrote:
> +lock	 - In this document from now on, the term lock and spin lock will
> +	   be synonymous.  These are locks that are used for SMP as well
> +	   as turning off preemption to protect areas of code on SMP machines.
Should the last SMP be UP?

--
			Gleb.
