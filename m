Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTEFSDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263924AbTEFSDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:03:20 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:58261 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263922AbTEFSDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:03:19 -0400
Date: Tue, 6 May 2003 09:30:06 -0700
From: Greg KH <greg@kroah.com>
To: Wade <neroz@ii.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-bk7: Where oh where have my sensors gone? (i2c)
Message-ID: <20030506163006.GA1296@kroah.com>
References: <20030427115644.GA492@zip.com.au> <20030428205522.GA26160@kroah.com> <20030505083458.GA621@zip.com.au> <20030505165848.GA1249@kroah.com> <3EB6AA01.30601@wmich.edu> <20030505182648.GA1826@kroah.com> <3EB6BCDF.2020300@wmich.edu> <20030505203927.GA2325@kroah.com> <1052211616.654.1.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052211616.654.1.camel@debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 05:00:16PM +0800, Wade wrote:
> On Tue, 2003-05-06 at 04:39, Greg KH wrote:
> > On Mon, May 05, 2003 at 03:34:55PM -0400, Ed Sweetman wrote:
> > > 
> > > Ok, then the sensors program that is part of the lm_sensors package is 
> > > just not up to date with the drivers since it complains about no 
> > > i2c-proc and has no options for looking at sysfs.
> > 
> > Yes, the libsensors code has not been updated yet, sorry.  I'm hoping
> > for some unification with the acpi/power management people too, as they
> > too care about power and temperature and fan settings.
> > 
> > > My via686a sensors seem to be working just fine in .69
> > 
> > Glad to hear it.
> 
> Thats strange. Mine don't, and never have in 2.5 - works in FreeBSD just
> fine though.

Does the 2.4 packages from the lmsensors web page work for you?  And if
so, are the drivers your hardware needs currently in the 2.5 tree yet?
If not, want to port them?  If so, please let us know.

thanks,

greg k-h
