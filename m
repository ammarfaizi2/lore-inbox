Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWEFMmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWEFMmz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 08:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWEFMmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 08:42:55 -0400
Received: from khc.piap.pl ([195.187.100.11]:61714 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750805AbWEFMmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 08:42:55 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: "Dave Airlie" <airlied@gmail.com>, "Greg KH" <greg@kroah.com>,
       "Ian Romanick" <idr@us.ibm.com>, "Dave Airlie" <airlied@linux.ie>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
References: <mj+md-20060504.211425.25445.atrey@ucw.cz>
	<445BA584.40309@us.ibm.com>
	<9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com>
	<20060505202603.GB6413@kroah.com>
	<9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
	<20060505210614.GB7365@kroah.com>
	<9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
	<20060505222738.GA8985@kroah.com>
	<9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
	<21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com>
	<9e4733910605052039n7d2debbse0fd07e0d1d059fb@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 06 May 2006 14:42:52 +0200
In-Reply-To: <9e4733910605052039n7d2debbse0fd07e0d1d059fb@mail.gmail.com> (Jon Smirl's message of "Fri, 5 May 2006 23:39:44 -0400")
Message-ID: <m3d5er729f.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jon Smirl" <jonsmirl@gmail.com> writes:

> The minimal vga driver combined with new_id scheme is very simple, it
> works on older kernels, it does not create a new API and it tracks
> ownership of the hardware state.

But it works only with VGAs (I, for example, use setpci-alike things
with non-VGA cards but it's dangerous - who knows if the BARs are set
correctly if the device wasn't enabled by the kernel).
-- 
Krzysztof Halasa
