Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbTEOPD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTEOPD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:03:58 -0400
Received: from kaboom.dsl.xmission.com ([166.70.87.226]:21928 "EHLO
	mail.oobleck.net") by vger.kernel.org with ESMTP id S264062AbTEOPDx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:03:53 -0400
Date: Thu, 15 May 2003 09:16:42 -0600 (MDT)
From: Chris Ricker <kaboom@gatech.edu>
X-X-Sender: kaboom@verdande.oobleck.net
Reply-To: Chris Ricker <kaboom@gatech.edu>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Mike Touloumtzis <miket@bluemug.com>, Ahmed Masud <masud@googgun.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <03051508174100.25285@tabby>
Message-ID: <Pine.LNX.4.55.0305150913471.6447@verdande.oobleck.net>
References: <20030514074403.GA18152@bluemug.com> <20030514205847.GA18514@bluemug.com>
 <Pine.LNX.4.53.0305141724220.12328@chaos> <03051508174100.25285@tabby>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Jesse Pollard wrote:

> On Wednesday 14 May 2003 16:32, Richard B. Johnson wrote:
> > Not so, with the latest Red Hat distribution (9). You can no longer
> > set init=/bin/bash at the boot prompt.... well you can set it, but
> > then you get an error about killing init. This caused a neighbor
> > a lot of trouble when she accidentally put a blank line in the
> > top of /etc/passwd. Nobody could log-in. I promised to show her
> > how to "break in", but I wasn't able to. I had to take her hard-disk
> > to my house, mount it, and fix the password file. All these "attempts"
> > at so-called security do is make customers pissed.
> 
> I fix those errors with by booting the Slackware CD with the live 
> filesystem...
> 
> No dependancies on any of the regular disks - then I can fix anything within
> reason (haven't tried md raids though).

You don't have to do that. Richard is mis-informed. Any of the following 
still work on Red Hat Linux 9:

init=/bin/bash         # drops you straight to a bash shell
init 1                 # runs runlevel 1 SysV init scripts and rc.sysinit
init single            # runs rc.sysinit, but not runlevel 1
init emergency         # runs a shell

all without going to rescue media.

later,
chris
