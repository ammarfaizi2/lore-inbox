Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbTGFAEL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 20:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbTGFAEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 20:04:11 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:20107 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266590AbTGFAEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 20:04:09 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 5 Jul 2003 17:10:56 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
In-Reply-To: <200307060210.32021.phillips@arcor.de>
Message-ID: <Pine.LNX.4.55.0307051710030.4599@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <200307051728.12891.phillips@arcor.de>
 <20030705121416.62afd279.akpm@osdl.org> <200307060210.32021.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003, Daniel Phillips wrote:

> On Saturday 05 July 2003 21:14, Andrew Morton wrote:
> > Daniel Phillips <phillips@arcor.de> wrote:
> > > Kgdb is no help in
> > > diagnosing, as the kgdb stub also goes comatose, or at least the serial
> > > link does.  No lockups have occurred so far when I was not interacting
> > > with the system via the keyboard or mouse.  Suggestions?
> >
> > Enable IO APIC, Local APIC, nmi watchdog.  Use serial console, see if you
> > can get a sysrq trace out of it.  That's `^A F T' in minicom.
>
> OK, tried that.  Still very dead.

Last resort, LKCD ;)



- Davide

