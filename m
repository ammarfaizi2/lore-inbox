Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318177AbSG2VJx>; Mon, 29 Jul 2002 17:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318180AbSG2VJx>; Mon, 29 Jul 2002 17:09:53 -0400
Received: from csl2.consultronics.on.ca ([204.138.93.2]:5276 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S318177AbSG2VJw>; Mon, 29 Jul 2002 17:09:52 -0400
Date: Mon, 29 Jul 2002 17:13:13 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3-ac4
Message-Id: <20020729171313.6957400c.glouis@dynamicro.on.ca>
In-Reply-To: <20020729164636.32b8929f.glouis@dynamicro.on.ca>
References: <200207291740.g6THewQ19578@devserv.devel.redhat.com>
	<008401c2372f$8c02cea0$0100a8c0@mars>
	<20020729164636.32b8929f.glouis@dynamicro.on.ca>
Organization: Dynamicro Consulting Limited
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002 16:46:36 -0400,
 Greg Louis <glouis@dynamicro.on.ca> wrote:

> The two inline functions containing these errors appear to be nowhere
> used, at least as far as I can tell with find -exec grep.

NOT correct, sorry.  The latter function _would_ have been used in
sched.c if it had compiled.  (Can't claim ENOTENOUGHCOFFEE at this time
of day; how about EINCIPIENTSENILITY?)

> Removing the
> code allows successful compilation on an SMP box, and it seems to be
> running ok with the new kernel.

Yeah, but we've disabled sched.c's load-balancing support.

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
