Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbTDQDtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 23:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTDQDtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 23:49:50 -0400
Received: from granite.he.net ([216.218.226.66]:60933 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262734AbTDQDtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 23:49:49 -0400
Date: Wed, 16 Apr 2003 21:03:54 -0700
From: Greg KH <greg@kroah.com>
To: Bartlomiej Czardybon <czar@jordan.pp.org.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uhci_hcd kernel panic in 2.5.67
Message-ID: <20030417040354.GC2201@kroah.com>
References: <20030416201612.GC8570@pik-net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416201612.GC8570@pik-net.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 10:16:12PM +0200, Bartlomiej Czardybon wrote:
> Hi
> 
> I find uhci_hcd module behaving very strangely on my system (Fujitsu Siemens
> Lifebook S-4546).
> 
> When I do (rmmod uhci_hcd ; modprobe uhci_hcd) I _always_ get kernel panic.

Known bug.  See the work-around patch in the latest -mm tree, or wait an
hour or so to send the fixes to Linus and the linux-usb-devel list for
this problem.

thanks,

greg k-h
