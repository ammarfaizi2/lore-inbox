Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbTEBSix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbTEBSix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:38:53 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:49311 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263079AbTEBSiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:38:52 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 2 May 2003 11:51:33 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <Pine.LNX.4.44.0305021325130.6565-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.50.0305021151060.1904-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0305021325130.6565-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 May 2003, Ingo Molnar wrote:

> > > Ingo, do you want protection against shell code injection ? Have the
> > > kernel to assign random stack addresses to processes and they won't be
> > > able to guess the stack pointer to place the jump. I use a very simple
> > > trick in my code :
> >
> > stack randomisation is already present in the kernel, in the form of
> > cacheline coloring for HT cpus...
>
> we could make it even more prominent than just coloring, to introduce the
> kind of variability that Davide's approach introduces. It has to be a
> separate patch obviously. This would further reduce the chance that a
> remote attack that has to guess the stack would succeed on a random box.

This definitely should take much code ;)



- Davide

