Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWG0Wq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWG0Wq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 18:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWG0Wq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 18:46:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:24241 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751047AbWG0Wq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 18:46:57 -0400
Date: Thu, 27 Jul 2006 15:42:35 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Shem Multinymous <multinymous@gmail.com>, Pavel Machek <pavel@suse.cz>,
       vojtech@suse.cz, Len Brown <len.brown@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org
Subject: Re: Generic battery interface
Message-ID: <20060727224235.GA23195@kroah.com>
References: <20060727002035.GA2896@elf.ucw.cz> <20060727140539.GA10835@srcf.ucam.org> <41840b750607270739u7b6fe7efl5ac5ec147d83e624@mail.gmail.com> <20060727144452.GB11707@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727144452.GB11707@srcf.ucam.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 03:44:52PM +0100, Matthew Garrett wrote:
> On Thu, Jul 27, 2006 at 05:39:06PM +0300, Shem Multinymous wrote:
> 
> > Can we really assume there's one driver providing all battery-related
> > attributes?
> 
> Hmm. That's a good point.
> 
> > So, if we insist on a standard battery device class name, how do we
> > cope with multiple sources of information and control functions?
> 
> Ignoring the multiple sources of information bit for the moment, we need 
> to figure out the correct method of event notification anyway. There's a 
> long-term plan to get rid of /proc/acpi, so acpi notifications need to 
> be more more generic in any case.

You can poll sysfs files to be notified when states change...

thanks,

greg k-h
