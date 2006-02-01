Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWBAN1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWBAN1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWBAN1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:27:36 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:3003 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964979AbWBAN1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:27:35 -0500
Date: Wed, 1 Feb 2006 14:26:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
Message-ID: <20060201132607.GA670@elte.hu>
References: <1138736609.7088.35.camel@localhost.localdomain> <20060201130818.GA26481@elte.hu> <1138800181.7088.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138800181.7088.51.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 2006-02-01 at 14:08 +0100, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > [pls. use -p when generating patches]
> > 
> 
> OK, how do you make quilt do that?

hm, i'm using 0.42, and this command:

  #!/bin/bash

  quilt refresh --diffstat --sort --no-timestamps -p 1 $@

does the -p thing automatically. (the -p option to quilt is for the 
patch-file-depth, not for the function-name thing.)

	Ingo
