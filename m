Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbSJCVfe>; Thu, 3 Oct 2002 17:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261323AbSJCVfE>; Thu, 3 Oct 2002 17:35:04 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:16141 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261211AbSJCVfB>;
	Thu, 3 Oct 2002 17:35:01 -0400
Date: Thu, 3 Oct 2002 14:37:37 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: Alexander Viro <viro@math.psu.edu>, Kevin Corry <corryk@us.ibm.com>,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
Message-ID: <20021003213736.GA1388@kroah.com>
References: <20021003161320.GA32588@kroah.com> <Pine.GSO.4.21.0210031217430.15787-100000@weyl.math.psu.edu> <20021003163018.GC32588@kroah.com> <m17xDXf-006hxpC@Mail.ZEDAT.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17xDXf-006hxpC@Mail.ZEDAT.FU-Berlin.DE>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 09:52:12PM +0200, Oliver Neukum wrote:
> 
> device != medium
> There's a need to report that as well.

I completely agree.  That's why I'm working on adding class support to
/sbin/hotplug which will enable all "mediums" that are added or removed
within the kernel to notify userspace of this event.

thanks,

greg k-h
