Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbTDXD01 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 23:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbTDXD00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 23:26:26 -0400
Received: from almesberger.net ([63.105.73.239]:15623 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264251AbTDXD0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 23:26:25 -0400
Date: Thu, 24 Apr 2003 00:37:42 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jamie Lokier <jamie@shareable.org>, Matthias Schniedermeyer <ms@citd.de>,
       Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424003742.J3557@almesberger.net>
References: <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25450000.1051152052@[10.10.2.4]>; from mbligh@aracnet.com on Wed, Apr 23, 2003 at 07:40:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> You turn it off once, and your distro keeps it that way. Doesn't seem
> that onerous to me. 

Okay, so now your distribution is aware of this configuration
issue.

> Indeed. Initial impression of people upgrading a kernel from 2.4 to 2.5/6
> is that "sound doesn't work in 2.5/6". Not good.

... but now it isn't. What gives ?

(Besides, you've just added the "silent" flag as another config item
besides the volume setting, using different interfaces, different
permissions, etc.)

> And all for the fact that when the user sets up the system, it just
> works. With sensible defaults. Instead of being an elitist piece of
> crap that only l33t g33ks can use.

Fine. But this discussion isn't about the end-user experience,
but about where a certain parameter should be set, and what its
transient default value should be.

Unexperienced users will just install a set of packages to upgrade
to a new kernel. So this change can just be included in one of
these upgrades. No superhuman effort needed.

As far as those are concerned who painstakingly build their own
kernel, update the things listed in Documentation/Changes, avoid
suble traps like CONFIG_SERIO_I8042, don't get confused by needing
new module utilities, etc., I'm fairly confident that they'll
consider setting the volume a rather minor challenge.

And you could even take the sting out of this one by adding an
appropriate warning to Documentation/Changes. That's a about all
the kernel-side support this issue deserves.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
