Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbULQT1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbULQT1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbULQTYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:24:54 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:4844 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262134AbULQTYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:24:18 -0500
Date: Fri, 17 Dec 2004 11:18:20 -0800
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@ximian.com>
Cc: ambx1@neo.rr.com, linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       len.brown@intel.com, shaohua.li@intel.com,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC] Device Resource Management
Message-ID: <20041217191819.GA21238@kroah.com>
References: <20041211054509.GA2661@neo.rr.com> <20041216041405.GA23223@kroah.com> <1103173505.6052.282.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103173505.6052.282.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 12:05:05AM -0500, Robert Love wrote:
> On Wed, 2004-12-15 at 20:14 -0800, Greg KH wrote:
> 
> > Why would it matter if we export this info to userspace?  Do any
> > userspace programs care about this information?
> 
> We'd love to be able to view and manipulate resource information from
> HAL.  As HAL replaces vendor-specific solutions such as, say, kudzu, it
> will need to make device/driver decisions and implement work arounds, so
> this information is incredibly invaluable, let alone just neat to have.

Ok, fair enough.  I keep forgetting about the PnP resource mess, I guess
I just want to block that nastiness out of my brain...

thanks,

greg k-h
