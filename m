Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTEOPVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264063AbTEOPVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:21:01 -0400
Received: from kaboom.dsl.xmission.com ([166.70.87.226]:14761 "EHLO
	mail.oobleck.net") by vger.kernel.org with ESMTP id S264054AbTEOPU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:20:59 -0400
Date: Thu, 15 May 2003 09:33:48 -0600 (MDT)
From: Chris Ricker <kaboom@gatech.edu>
X-X-Sender: kaboom@verdande.oobleck.net
Reply-To: Chris Ricker <kaboom@gatech.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Jesse Pollard <jesse@cats-chateau.net>,
       Mike Touloumtzis <miket@bluemug.com>, Ahmed Masud <masud@googgun.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <Pine.LNX.4.53.0305151121420.19950@chaos>
Message-ID: <Pine.LNX.4.55.0305150931140.6447@verdande.oobleck.net>
References: <20030514074403.GA18152@bluemug.com> <20030514205847.GA18514@bluemug.com>
 <Pine.LNX.4.53.0305141724220.12328@chaos> <03051508174100.25285@tabby>
 <Pine.LNX.4.55.0305150913471.6447@verdande.oobleck.net>
 <Pine.LNX.4.53.0305151121420.19950@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Richard B. Johnson wrote:

> > You don't have to do that. Richard is mis-informed. Any of the following
> > still work on Red Hat Linux 9:
> >
> > init=/bin/bash         # drops you straight to a bash shell
> > init 1                 # runs runlevel 1 SysV init scripts and rc.sysinit
> > init single            # runs rc.sysinit, but not runlevel 1
> > init emergency         # runs a shell
> >
> > all without going to rescue media.
> >
> 
> Bullshit. Try it.

I just did. It works.

If it's not working for you, it's because *you* did something (like, say, 
password your boot loader). By default, it's still possible on Red Hat Linux 
9 out of the box.

later,
chris
