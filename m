Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264291AbUESQIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUESQIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 12:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUESQIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 12:08:55 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:41674 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264291AbUESQIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 12:08:49 -0400
Message-ID: <1231.128.150.143.219.1084982960.squirrel@webmail.seven4sky.com>
In-Reply-To: <40A9E239.4010909@cs.up.ac.za>
References: <40A9E239.4010909@cs.up.ac.za>
Date: Wed, 19 May 2004 12:09:20 -0400 (EDT)
Subject: Re: NFS deadlock
From: samg@seven4sky.com
To: "Jaco Kroon" <jkroon@cs.up.ac.za>
Cc: linux-kernel@vger.kernel.org, acooks@cs.up.ac.za
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaco,

How are your boxes locking up, I have nfs in use every day,
does rpc die?

what kernel are you using?
and are you transfering linux to linux, or to some other platform.

The only time I had problems was when my client locked up
because I disconnected the server, and it hung the client,
the only solution (based on the way I connected), was to reboot.
To make matters worse, I rean a script that used du every day, and
so there were 12+ instances of du, all trying to run about.

I would suggest using a program like sysstat, or sar, to help you
analyse the issues at hand.

 -sam

> Hello there
>
> I've once again got problems with the kernel locking up.  I'm now
> convinced that it has something to do with NFS.
>
> Previously weve had 2 machines that locked up, plus my one at home,
> resulting in three machines.  Sometimes they would recover by themselves
> after some time, other times they could be left for 2 days or so without
> recovering.  All three of these use NFS to export files to other
> machines, it's the only thing we can find they have in common, other
> that x86 architecture, but then other machines would be dying as well.
> It should be noted that none of these runs on the newest hardware, but
> that should not matter, neither does any of our other servers.  We have
> a 3rd NFS server, which doesn't take nearly as heavy load via NFS.  I've
> been wondering why it hasn't locked up either, and this morning (right
> now in fact) it has decided that it is it's turn and is currently
> unusable.
>
> If anybody else is experiencing similar problems, or have possible work
> arounds, it would be appreciated if you could share your knowledge.
>
> Jaco
>
> ===========================================
> This message and attachments are subject to a disclaimer. Please refer to
> www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
> Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig.
> Volledige besonderhede is by
> www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
> ===========================================
>
>

