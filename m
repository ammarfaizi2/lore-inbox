Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVA0Tqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVA0Tqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVA0Tqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:46:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37304 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262710AbVA0Tq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:46:27 -0500
Date: Thu, 27 Jan 2005 14:46:03 -0500
From: Dave Jones <davej@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 1/6  introduce sysctl
Message-ID: <20050127194603.GA31127@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@ucw.cz>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
References: <20050127101117.GA9760@infradead.org> <20050127101201.GB9760@infradead.org> <20050127181525.GA4784@elf.ucw.cz> <20050127191120.GA10460@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127191120.GA10460@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 08:11:20PM +0100, Ingo Molnar wrote:

 > so, i'm glad to report, it's a non-issue. Sometimes developers want to
 > disable randomisation during development (quick'n'easy hacks get quicker
 > and easier - e.g. if you watch an address within gdb), so having the
 > capability for unprivileged users to disable randomisation on the fly is
 > useful and Fedora certainly offers that, but from a support and
 > bug-reporting POV it's not a problem.

It's worth noting that some users have found the randomisation disable useful
for running things like xine/mplayer etc with win32 codecs that seem
to just segfault otherwise.  These things seem to be incredibly fragile
to address space layout changes, which is a good argument for trying to
avoid these wierdo formats where possible in favour of free codecs.

		Dave

