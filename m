Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbVJUNpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVJUNpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVJUNpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:45:30 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:55023 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964946AbVJUNp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:45:29 -0400
Date: Fri, 21 Oct 2005 09:45:20 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: False positive (well not really) on RT backward clock check
Message-ID: <Pine.LNX.4.58.0510210942180.3903@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,

Just want to let you know that I got the warning of the clock going
backwards on boot up.  But it happened right after I got this message.

Ktimers: Switched to high resolution mode CPU 0

So I'm assuming that the clock can go backwards by the switch to high res
timers.

-- Steve
