Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVDNAyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVDNAyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVDNAyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:54:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:42705 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261402AbVDNAyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:54:18 -0400
Date: Wed, 13 Apr 2005 17:54:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050413175407.3e5285ea.akpm@osdl.org>
In-Reply-To: <200504132038.52377.tomlins@cam.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<200504132015.49877.tomlins@cam.org>
	<20050413172039.4502b2a9.akpm@osdl.org>
	<200504132038.52377.tomlins@cam.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
> On Wednesday 13 April 2005 20:20, Andrew Morton wrote:
>  > Ed Tomlinson <tomlins@cam.org> wrote:
>  > >
>  > > > Don't think so - it works OK here.  Checked the .config?  Does the serial
>  > >  > port work if you do `echo foo > /dev/ttyS0'?  ACPI?
>  > > 
>  > >  Turned out it was some old ups software that got reactivated on the box displaying the
>  > >  console - was a pain to disable it....
>  > 
>  > OK.
>  > 
>  > >  In any case, when the box reboots there are not any messages.  Any ideas on what debug
>  > >  options to enable or suggestions on how we can figure out the cause of the reboots.
>  > 
>  > There were a few problems in the task switching area - maybe that.
> 
>  These hit arch/i386.  Are they going to help on an x86_64 box?

nope.
