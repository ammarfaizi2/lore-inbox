Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTLFVBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 16:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbTLFVBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 16:01:09 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:1152 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265248AbTLFVBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 16:01:06 -0500
Date: Sat, 6 Dec 2003 16:00:02 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Markku Savela <msa@burp.tkv.asdf.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11, TSC cannot be used as a timesource.
In-Reply-To: <200312062056.hB6Kuh0D001004@burp.tkv.asdf.org>
Message-ID: <Pine.LNX.4.58.0312061559040.1758@montezuma.fsmlabs.com>
References: <200312061603.hB6G3CrG012634@burp.tkv.asdf.org>
 <Pine.LNX.4.58.0312061253010.10548@montezuma.fsmlabs.com>
 <200312062056.hB6Kuh0D001004@burp.tkv.asdf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Dec 2003, Markku Savela wrote:

> > Does this only happen when running X11?
>
> Hmm.. possibly. When I boot single user, it does not appear to happen.
>
> After "init 2" and X and everything running, the notice appears in
> about 5-10 minutes. All I have in X is couple of XTerms and doing
> occasional "dmesg". I have Gnome2 with Sawfish, and GKrellM running.
>
> Yes, my X is for older kernel
>
>   XFree86 Version 4.3.0
>   Release Date: 27 February 2003
>   X Protocol Version 11, Revision 0, Release 6.6
>   Build Operating System: Linux 2.4.18-24.8.0smp i686 [ELF]
>
> and I had to disable "dri" loading totally. If I enable "dri", and
> start X that uses it, the machines crashes totally, no X logs, no
> syslog or anything comes out. Total death (I just assumes that
> expecting DRI to work was just too much). Maybe I should disable all
> acceleration...

Hmm ok i was actually suspecting something DRI related. Can you send an
lspci? and perhaps full dmesg?

