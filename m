Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUACF7p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 00:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbUACF7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 00:59:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:6594 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262705AbUACF7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 00:59:43 -0500
Date: Fri, 2 Jan 2004 21:59:38 -0800
From: Greg KH <greg@kroah.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040103055938.GD5306@kroah.com>
References: <20031231002942.GB2875@kroah.com> <20040101011855.GA13628@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101011855.GA13628@hh.idb.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 02:18:55AM +0100, Helge Hafting wrote:
> On Tue, Dec 30, 2003 at 04:29:42PM -0800, Greg KH wrote:
> > 
> >  2) We are (well, were) running out of major and minor numbers for
> >     devices.
> 
> devfs tried to fix this one by _getting rid_ of those numbers.
> Seriously - what are they needed for?  

But devfs failed in this.  The devfs kernel interface still requires a
major/minor number to create device nodes.

Hopefully I can work on fixing this up in 2.7.

thanks,

greg k-h
