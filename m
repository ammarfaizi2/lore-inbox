Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUCCTdW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbUCCTdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:33:22 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:40845 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262556AbUCCTdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:33:17 -0500
Message-ID: <404631C8.4000804@pacbell.net>
Date: Wed, 03 Mar 2004 11:28:08 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Ed Tomlinson <edt@aei.ca>, Michael Weiser <michael@weiser.dinsnail.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net> <200403030722.17632.edt@aei.ca> <20040303151433.GC25687@kroah.com>
In-Reply-To: <20040303151433.GC25687@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Users need to learn that the kernel is changing models from one which
> automatically loaded modules when userspace tried to access the device,
> to one where the proper modules are loaded when the hardware is found.
> 
> Note that this is a much more sane model due to removable devices, and
> instances of multiple types of the same kind of devices in the same
> system.


Actually I think that sysadmin frameworks are the ones that'll have
the hardest time changing.  It's a different way to look at system
configuration, and changing basic models incrementally may not work.
User adoption normally lags sysadmin adoption for such stuff.  (Yes,
developers often wear both of those hats too.)


Luckily, all the usermode frameworks to boot and configure Linux have
had since the 2.4.0 kernel (or was that 2.4.0-test10?) to start moving
from that "historical UNIX" sysadmin model to something more modern;
Linux devices have been hotplugging for quite a while now.  All that
2.6 changed was to use it more universally; and with sysfs, that also
means stuff like "udev" is now possible.

Which means that any day now, all Linux systems (and their users,
docs, and sysadmin procedures) will be done converting!

- Dave

p.s.    You in the back there saying "Huh?  NOT!!!".  Be quiet.

p.p.s.  And that "we shall coexist" chanting -- enough already!

;-)

