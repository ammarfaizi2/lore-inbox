Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWEWSWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWEWSWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWEWSWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:22:00 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:52474 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751172AbWEWSV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:21:59 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Steven Rostedt <rostedt@goodmis.org>
To: Yann.LEPROVOST@wavecom.fr
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <OFCEBD2C92.B402353B-ONC1257177.005E2101-C1257177.005EEA9E@wavecom.fr>
References: <OFCEBD2C92.B402353B-ONC1257177.005E2101-C1257177.005EEA9E@wavecom.fr>
Content-Type: text/plain
Date: Tue, 23 May 2006 14:21:36 -0400
Message-Id: <1148408496.24623.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 19:10 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> Currently there are only system timer and debug serial unit registered on
> irq line 1.
> Debug serial unit is used as the console !
> 

That scares me.  Is the debug serial unit added by you, or is it part of
the mainline kernel?

-- Steve


