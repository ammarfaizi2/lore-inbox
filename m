Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTEEUZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbTEEUZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:25:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:17318 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261288AbTEEUZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:25:04 -0400
Date: Mon, 5 May 2003 13:39:27 -0700
From: Greg KH <greg@kroah.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-bk7: Where oh where have my sensors gone? (i2c)
Message-ID: <20030505203927.GA2325@kroah.com>
References: <20030427115644.GA492@zip.com.au> <20030428205522.GA26160@kroah.com> <20030505083458.GA621@zip.com.au> <20030505165848.GA1249@kroah.com> <3EB6AA01.30601@wmich.edu> <20030505182648.GA1826@kroah.com> <3EB6BCDF.2020300@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB6BCDF.2020300@wmich.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 03:34:55PM -0400, Ed Sweetman wrote:
> 
> Ok, then the sensors program that is part of the lm_sensors package is 
> just not up to date with the drivers since it complains about no 
> i2c-proc and has no options for looking at sysfs.

Yes, the libsensors code has not been updated yet, sorry.  I'm hoping
for some unification with the acpi/power management people too, as they
too care about power and temperature and fan settings.

> My via686a sensors seem to be working just fine in .69

Glad to hear it.

greg k-h
