Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbUACVSn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUACVSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:18:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17874 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264264AbUACVSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:18:39 -0500
Date: Sat, 3 Jan 2004 21:18:37 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040103211837.GW4176@parcelfarce.linux.theplanet.co.uk>
References: <20031231002942.GB2875@kroah.com> <20040101011855.GA13628@hh.idb.hist.no> <20040103055938.GD5306@kroah.com> <20040103152241.GA5531@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103152241.GA5531@hh.idb.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 04:22:41PM +0100, Helge Hafting wrote:
> On Fri, Jan 02, 2004 at 09:59:38PM -0800, Greg KH wrote:
> > On Thu, Jan 01, 2004 at 02:18:55AM +0100, Helge Hafting wrote:
> > > On Tue, Dec 30, 2003 at 04:29:42PM -0800, Greg KH wrote:
> > > > 
> > > >  2) We are (well, were) running out of major and minor numbers for
> > > >     devices.
> > > 
> > > devfs tried to fix this one by _getting rid_ of those numbers.
> > > Seriously - what are they needed for?  
> > 
> > But devfs failed in this.  The devfs kernel interface still requires a
> > major/minor number to create device nodes.
> > 
> Yes.  The numbers went unused in the common case of opening a device by name though.

No, they were not.  RTFS, please.
