Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTDKWoT (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbTDKWm5 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:42:57 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48021 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262000AbTDKWmu (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:42:50 -0400
Date: Fri, 11 Apr 2003 15:51:37 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Jeremy Jackson'" <jerj@coplanar.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411225137.GB3786@kroah.com>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAA44@orsmsx116.jf.intel.com> <Pine.LNX.4.44.0304111347370.8422-100000@dlang.diginsite.com> <20030411205948.GV1821@kroah.com> <3E974299.3030701@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E974299.3030701@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 03:32:57PM -0700, Steven Dake wrote:
> 
> I've been thinking of how to solve this particular problem, and believe 
> you could use dnotify in a daemon to track permission and ownership 
> changes and store them in a backing database.  In fact, we do something 
> similiar to this today.  This allows the user to use any type of 
> application for changing permissions/owners, even syscalls directly 
> without having to go "through" any sort of tracking database.

That would be cool.  But I think we need to add dnotify support to sysfs
first :)

thanks,

greg k-h
