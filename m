Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbTEFIsb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTEFIsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:48:31 -0400
Received: from mail-07.iinet.net.au ([203.59.3.39]:1034 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261174AbTEFIsa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:48:30 -0400
Subject: Re: 2.5.68-bk7: Where oh where have my sensors gone? (i2c)
From: Wade <neroz@ii.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030505203927.GA2325@kroah.com>
References: <20030427115644.GA492@zip.com.au>
	 <20030428205522.GA26160@kroah.com> <20030505083458.GA621@zip.com.au>
	 <20030505165848.GA1249@kroah.com> <3EB6AA01.30601@wmich.edu>
	 <20030505182648.GA1826@kroah.com> <3EB6BCDF.2020300@wmich.edu>
	 <20030505203927.GA2325@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052211616.654.1.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 May 2003 17:00:16 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 04:39, Greg KH wrote:
> On Mon, May 05, 2003 at 03:34:55PM -0400, Ed Sweetman wrote:
> > 
> > Ok, then the sensors program that is part of the lm_sensors package is 
> > just not up to date with the drivers since it complains about no 
> > i2c-proc and has no options for looking at sysfs.
> 
> Yes, the libsensors code has not been updated yet, sorry.  I'm hoping
> for some unification with the acpi/power management people too, as they
> too care about power and temperature and fan settings.
> 
> > My via686a sensors seem to be working just fine in .69
> 
> Glad to hear it.

Thats strange. Mine don't, and never have in 2.5 - works in FreeBSD just
fine though.

