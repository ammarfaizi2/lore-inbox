Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTDKQ6s (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTDKQ6s (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:58:48 -0400
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.114.72.97]:1541
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id S261308AbTDKQ6r (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 12:58:47 -0400
Subject: Re: [ANNOUNCE] udev 0.1 release
From: Jeremy Jackson <jerj@coplanar.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20030411032424.GA3688@kroah.com>
References: <20030411032424.GA3688@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050081047.1252.4.camel@contact.skynet.coplanar.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 11 Apr 2003 13:10:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about read-only root fs?  What about the root= kernel command line
ever working?  What about initrd issues?

On Thu, 2003-04-10 at 23:24, Greg KH wrote:
> Hi all,
> 
> I'd like to finally announce the previously vapor-ware udev program that
> I've talked a lot about with a lot of people over the past months.  The
> first, very rough cut is at:
> 	kernel.org/pub/linux/utils/kernel/hotplug/udev-0.1.tar.gz
> 
> But what is it?  I've included an initial design document below that was
> originally written by Dan Stekloff, and hacked up a bit by me.  But in
> short, udev is a userspace replacement for devfs.  It will create and
> destroy /dev entries based on the current system configuration.  It does
> this by watching the /sbin/hotplug events on the system, and reading
> information about these events from sysfs.
> 


