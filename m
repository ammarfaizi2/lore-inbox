Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293461AbSCOXBz>; Fri, 15 Mar 2002 18:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSCOXBp>; Fri, 15 Mar 2002 18:01:45 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:58629 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293465AbSCOXBc>;
	Fri, 15 Mar 2002 18:01:32 -0500
Date: Fri, 15 Mar 2002 15:01:31 -0800
From: Greg KH <greg@kroah.com>
To: rob1@rekl.yi.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: IP Autoconfig doesn't work for USB network devices
Message-ID: <20020315230131.GC5563@kroah.com>
In-Reply-To: <Pine.LNX.4.40.0203142010380.12787-100000@rekl.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0203142010380.12787-100000@rekl.dyn.dhs.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 15 Feb 2002 19:01:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 08:29:54PM -0600, rob1@rekl.yi.org wrote:
> 
> Is there any way to get the USB network device recognized before IP
> autoconfig is executed?

You don't mention which kernel version you are using, what one are you
using?

You might try the patches mentioned in this thread:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101501210231463
as it seems that the problem is your device is not seen by the USB
subsystem before the network code starts up.

greg k-h
