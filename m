Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266480AbSKLLW3>; Tue, 12 Nov 2002 06:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSKLLW3>; Tue, 12 Nov 2002 06:22:29 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:3083 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S266480AbSKLLWY>; Tue, 12 Nov 2002 06:22:24 -0500
Message-ID: <3DD0E61D.7F24D978@aitel.hist.no>
Date: Tue, 12 Nov 2002 12:29:33 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>, Xavier Bestel <xavier.bestel@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: devfs
References: <Pine.GSO.4.21.0211120445570.29617-100000@steklov.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On 12 Nov 2002, Xavier Bestel wrote:
> 
> > I'm wondering if a totally userspace solution could replace devs ?
> > Something using hotplug + sysfs and creating directories/nodes as they
> > appear on the system. This way, the policy (how do I name what) could be
> > moved out of the kernel.
> 
>         Guys, may I remind you that Oct 31 had been more than a week ago?
> Devfs *is* a race-ridden pile of crap, but we are in a goddamn feature
> freeze, so let's get real.
> 
A kernel feature freeze don't apply to a pure userspace implemetation,
so let him try.  :-)  It won't affect the current devfs code, it'll
simply be configured out.
/dev on tmpfs, populated by hotplug. Could be interesting to see.

[...]
>         Now, does somebody have technical comments on the proposed changes?

Only the obvious - a cleanup is generally good and so is getting rid
of unused parameters.

Helge Hafting
