Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbUKSAXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbUKSAXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUKSAV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:21:28 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:7673 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261212AbUKSASb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:18:31 -0500
Date: Thu, 18 Nov 2004 16:18:17 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] a very tiny /sbin/hotplug
Message-ID: <20041119001817.GA11847@kroah.com>
References: <20041118231406.GA11239@kroah.com> <20041118234629.GA3046@gate.ebshome.net> <20041118235301.GD19750@rikers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118235301.GD19750@rikers.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 05:53:01PM -0600, Chris Larson wrote:
> * Eugene Surovegin (ebs@ebshome.net) wrote:
> > On Thu, Nov 18, 2004 at 03:14:06PM -0800, Greg Kroah-Hartman wrote:
> > > So, a number of people have complained over the past few years about the
> > > fact that /sbin/hotplug was a shell script.  Funny enough, it's the
> > > people on the huge boxes, with huge number of devices that are
> > > complaining, not the embedded people with limited resources (ironic,
> > > isn't it...)
> > 
> > This is probably because embedded people don't use hotplug at all :).
> > On dozen different PPC and MIPS boxes I worked on, we never needed 
> > this feature.
> 
> I tend to focus on ARM, and find this very useful.  I know of a number
> of folks using erik andersen's "diethotplug" (which hasnt been touched
> in some time).  I look forward to your further hotplug improvements.

Yes, diethotplug is based on my old package called, supprise,
diethotplug, and is located at
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/

But that only does module loading.  The "full" replacement of today's
/sbin/hotplug functionality needs this hotplug multiplexer, and a
diethotplug replacement (which can get much smaller than the current
diethotplug due to the way modprobe works in 2.6.)

thanks,

greg k-h
