Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVAPXno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVAPXno (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 18:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVAPXno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 18:43:44 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:36245
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262649AbVAPXnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 18:43:39 -0500
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Karim Yaghmour <karim@opersys.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Tom Zanussi <zanussi@us.ibm.com>
In-Reply-To: <41E9EC5A.7070502@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <1105742791.13265.3.camel@tglx.tec.linutronix.de>
	 <41E8543A.8050304@am.sony.com>
	 <1105794499.13265.247.camel@tglx.tec.linutronix.de>
	 <41E9CCEF.50401@opersys.com> <Pine.LNX.4.61.0501160352130.6118@scrub.home>
	 <41E9EC5A.7070502@opersys.com>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 00:43:36 +0100
Message-Id: <1105919017.13265.275.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-15 at 23:23 -0500, Karim Yaghmour wrote:
> > Well, that's really a core problem. We don't want to duplicate 
> > infrastructure, which practically does the same. So if relayfs isn't 
> > usable in this kind of situation, it really raises the question whether 
> > relayfs is usable at all. We need to make relayfs generally usable, 
> > otherwise it will join the fate of devfs.
> 
> Hmm, coming from you I will take this is a pretty strong endorsement
> for what I was suggesting earlier: provide a basic buffering mode
> in relayfs to be used in kernel debugging. However, it must be
> understood that this is separate from the existing modes and ltt,
> for example, could not use such a basic infrastructure. If this is
> ok with you, and no one wants to complain too loudly about this, I
> will go ahead and add this to our to-do list for relayfs.

This implies to seperate 

- infrastructure 
- event registration
- transport mechanism

tglx


