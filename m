Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUGHPa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUGHPa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUGHPa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:30:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:9962 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264246AbUGHPaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:30:23 -0400
Date: Thu, 8 Jul 2004 08:28:13 -0700
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: Linda Xie <lxiep@us.ibm.com>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] 2.6 PCI Hotplug: receive PPC64 EEH events
Message-ID: <20040708152813.GB12854@kroah.com>
References: <20040707155907.G21634@forte.austin.ibm.com> <40EC9A02.1000507@us.ibm.com> <20040707190642.J21634@forte.austin.ibm.com> <20040708060933.GE548@kroah.com> <20040708102425.L21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708102425.L21634@forte.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 10:24:25AM -0500, linas@austin.ibm.com wrote:
> On Wed, Jul 07, 2004 at 11:09:33PM -0700, Greg KH wrote:
> > > pci_scan_child_bus() is currently ...
> >
> > It's in the latest -bk tree, right?
> 
> yes, it looks correct in the current tree (it wasn't when 
> I'd previously cloned).    It's possible I'm not using bk correctly;
> once I've modified a file, 'bk pull' never merges in newer changes 
> made upstream.  So I have to 'bk clone' all the time, which is a 
> pain in the neck. What am I doing wrong?

Not checking in your file before pulling.

greg k-h
