Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTDKT6C (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbTDKT6C (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:58:02 -0400
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:32923 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id S261649AbTDKT6B (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 15:58:01 -0400
Date: Fri, 11 Apr 2003 21:09:44 +0100
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: Greg KH <greg@kroah.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net, message-bus-list@redhat.com,
       Daniel Stekloff <dsteklof@us.ibm.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411200944.GA3232@axis.demon.co.uk>
References: <20030411032424.GA3688@kroah.com> <Pine.LNX.4.44.0304111939310.12110-100000@serv> <20030411181245.GD1821@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411181245.GD1821@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 11:12:45AM -0700, Greg KH wrote:
> On Fri, Apr 11, 2003 at 08:02:41PM +0200, Roman Zippel wrote:
> > To help serialization and perfomance issues, it might help to add a daemon 
> > mode to hotplug. The kernel calls hotplug with a pipe from which it reads 
> > the event data, after a certain timeout it can close the pipe and exit.
> 
> Yes, this is probably what is going to happen soon.

Excellent!  This should fix our continuing problems with many
identical USB devices on one bus!  In particular 6 keyspans quad
serial ports on the same USB bus never come up in the same order with
hotplug which is a bit embarrassing.  Without hotplug they come up in
the right order every time!

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
