Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVAKKkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVAKKkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVAKKkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:40:11 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26770
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262689AbVAKKj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:39:57 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Edjard Souza Mota <edjard@gmail.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <4d6522b905011102052e16092e@mail.gmail.com>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <4d6522b905011101202918f361@mail.gmail.com>
	 <1105435846.17853.85.camel@tglx.tec.linutronix.de>
	 <20050111095616.GH26799@dualathlon.random>
	 <4d6522b905011102052e16092e@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 11:39:53 +0100
Message-Id: <1105439993.17853.98.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 12:05 +0200, Edjard Souza Mota wrote:

> Yes, agreed. Our point was just to re-organize current OOM killer to release the
> kernel from doing rating, which is not its task any way.

It is a kernel task and will always be a kernel task. The kernel manages
memory resources and therefor is the place which is responsible to solve
the oom situation.

The userland daemon or what ever can only be a add on to give a hint for
the final decision.

tglx




