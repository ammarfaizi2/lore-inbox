Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUKSWwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUKSWwo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUKSWud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:50:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:42423 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261672AbUKSWtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:49:01 -0500
Date: Fri, 19 Nov 2004 14:48:22 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Mathieu Segaud <matt@minas-morgul.org>,
       Hotplug Devel <linux-hotplug-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 046 release
Message-ID: <20041119224822.GA18211@kroah.com>
References: <20041118224411.GA10876@kroah.com> <87sm76oz9z.fsf@barad-dur.crans.org> <1100875339.18701.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100875339.18701.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 03:42:19PM +0100, Kay Sievers wrote:
> On Fri, 2004-11-19 at 12:26 +0100, Mathieu Segaud wrote:
> > seems like these changes broke something in rules applying to eth* devices.
> > the rules put and still working with udev 045 have no effect, now....
> > not so inconvenient now that I've got just one card in my box, but I guess
> > it could be a show-stopper for laptop users.
> > 
> > My rules which can be found at the end of /etc/udev/rules.d/50-udev.rules are:
> > 
> > KERNEL="eth*", SYSFS{address}="00:10:5a:49:36:d8", NAME="external"
> > KERNEL="eth*", SYSFS{address}="00:50:04:69:db:56", NAME="private"
> > KERNEL="eth*", SYSFS{address}="00:0c:6e:e4:2c:81", NAME="dmz"
> 
> This should fix it.

Applied, thanks.

greg k-h
