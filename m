Return-Path: <linux-kernel-owner+w=401wt.eu-S932560AbXAQQRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbXAQQRk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbXAQQRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:17:40 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55690 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932560AbXAQQRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:17:39 -0500
Date: Wed, 17 Jan 2007 11:17:37 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] Kwatch: kernel watchpoints using CPU debug registers
In-Reply-To: <20070117094454.GB19093@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0701171114040.2381-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2007, Ingo Molnar wrote:

> * Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > From: Alan Stern <stern@rowland.harvard.edu>
> > 
> > This patch (as839) implements the Kwatch (kernel-space hardware-based 
> > watchpoints) API for the i386 architecture.  The API is explained in 
> > the kerneldoc for register_kwatch() in arch/i386/kernel/kwatch.c.
> 
> i think it would be nice to have this ontop of Roland's utrace 
> infrastructure, which nicely modularizes all hardware debugging 
> capabilities and detaches it from ptrace.

I'll be happy to move this over to the utrace setting, once it is merged.  
Do you think it would be better to include the current version of kwatch 
now or to wait for utrace?

Roland, is there a schedule for when you plan to get utrace into -mm?

Alan Stern

