Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWCZHsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWCZHsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 02:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWCZHsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 02:48:16 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:49093 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751158AbWCZHsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 02:48:15 -0500
Date: Sun, 26 Mar 2006 09:45:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 00/10] PI-futex: -V1
Message-ID: <20060326074535.GA9969@elte.hu>
References: <20060325184528.GA16724@elte.hu> <20060326045404.GA9308@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326045404.GA9308@gnuppy.monkey.org>
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


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> You'll need to do priority ceiling emulation as well. [...]

i mentioned it further down in the text - PRIO_PROTECT support (which is 
priority ceiling) is planned for pthread mutexes. It needs no further 
kernel changes, it's a pure userspace thing.

	Ingo
