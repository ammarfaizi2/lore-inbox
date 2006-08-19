Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422719AbWHSRIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWHSRIg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 13:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422721AbWHSRIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 13:08:36 -0400
Received: from web36603.mail.mud.yahoo.com ([209.191.85.20]:46164 "HELO
	web36603.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422720AbWHSRIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 13:08:35 -0400
Message-ID: <20060819170834.17845.qmail@web36603.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Sat, 19 Aug 2006 10:08:34 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] [PATCH] file posix capabilities
To: Crispin Cowan <crispin@novell.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
In-Reply-To: <44E6714C.3090707@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Crispin Cowan <crispin@novell.com> wrote:

> >  At least some of the Linux capabilities lend
> themselves to easy
> > privilege escalation to gaining other capabilities
> or effectively
> > bypassing them.
> >   
> Certainly; cap_sys_admin effectively gives you
> ownership of the machine.
> But that is fundamental to the POSIX Capabilities
> model, and not
> something that Serge can change.

In turn it is fundamental to the curious
granularity of privileged operations in Unix.

I maintain that the real value in the POSIX
capability model derives from seperating the
permission to violate policy from the UID.

Granularity of such privilege is a bonus, and
a matter of considerable debate. DGUX ended
up with over 330 distinct capabilities, while
Irix had (last I looked) 24, and Solaris
came in somewhere between. All these systems
work.


Casey Schaufler
casey@schaufler-ca.com
