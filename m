Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTENVRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTENVRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:17:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:38785 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262818AbTENVRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:17:00 -0400
Date: Wed, 14 May 2003 17:32:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mike Touloumtzis <miket@bluemug.com>
cc: Ahmed Masud <masud@googgun.com>, Chuck Ebbert <76306.1226@compuserve.com>,
       Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <20030514205847.GA18514@bluemug.com>
Message-ID: <Pine.LNX.4.53.0305141724220.12328@chaos>
References: <20030514074403.GA18152@bluemug.com>
 <Pine.LNX.4.33.0305140608070.10480-100000@marauder.googgun.com>
 <20030514205847.GA18514@bluemug.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Mike Touloumtzis wrote:

> On Wed, May 14, 2003 at 06:34:30AM -0400, Ahmed Masud wrote:
> >
> > Level of security is a matter of trust.  Should the kernel trust a
> > distribution provider? No, that is not a reasonable request, because we do
> > not control their environment and evaluation proceedures and there are no
> > guarentees between the channel that provides the operating system to the
> > time it gets installed on a system.
>
> I don't understand why people are willing to base security arguments
> on some sort of bizarre adversarial relationship between the kernel and
> the system tools.
>
> No Unix (even a "secure" one) is designed to run all security-critical
> code in the kernel.  That would be a bad design anyway, since it would
> run lots of code at an unwarranted privilege level.  "login" is not
> part of the kernel.  "su" is not part of the kernel".  The boot loader
> is not part of the kernel.  And so on.
>
> There is no issue of "trust" between the kernel and the distribution
> provider.  The distribution provider provides a system, which (like all
> Unix-derived systems) is modular and thus has multiple independent
> components with security functions.  The sum of those parts is what you
> should evaluate for security.  Yes, the system should include proper
> isolation mechanisms to prevent improper privilege escalations.  But it
> doesn't make sense to even think about what the kernel should do when
> the untrusted distribution provides a malicious "/sbin/init".

Not even malicious. For years, it was accepted that if you had
physical possesion of a computing system, you could do anything
with it that it was capable of.

Not so, with the latest Red Hat distribution (9). You can no longer
set init=/bin/bash at the boot prompt.... well you can set it, but
then you get an error about killing init. This caused a neighbor
a lot of trouble when she accidentally put a blank line in the
top of /etc/passwd. Nobody could log-in. I promised to show her
how to "break in", but I wasn't able to. I had to take her hard-disk
to my house, mount it, and fix the password file. All these "attempts"
at so-called security do is make customers pissed.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

