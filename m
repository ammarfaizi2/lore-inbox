Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269910AbUIDMId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269910AbUIDMId (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269912AbUIDMId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:08:33 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:53697 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S269910AbUIDMIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:08:31 -0400
Message-ID: <4139B03A.6040706@tungstengraphics.com>
Date: Sat, 04 Sep 2004 13:08:26 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com> <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com>
In-Reply-To: <20040904115442.GD2785@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> There's already a per-distro mechanism to make all this all nice and
> transparent to end-users.  In Fedora, we even have 3 (apt-get/yum/up2date).
> The problem is when 3rd parties like the DRI project expect users not to
> use the tools they are familiar with, and expect them to run off to fetch
> bits from websites and replace random bits of their system.
> 
> Who do you think gets the support calls and blame when the X server breaks
> because the user bodged it ?

I think they get shared out pretty evenly between dri-users and your lot.  We 
all agree there's a problem, I'm happy to do what it takes to move towards a 
solution.

In the past, redhat & other vendors have only tracked XFree86 release cycles, 
which weren't exactly timely, and in the most recent instance, didn't even 
include an up-to-date DRI.  Although we've mainly been bitching about the 
kernel, the real drag has been userspace updates.

So, we are coming out of a period of history where it was extremely difficult 
to get our drivers to users through the 'official' channels - to the extent 
that many people have given up on the possibility of them working properly. 
Maybe things will improve now.

Are you suggesting for instance, that RedHat might pick up individual drivers 
out of Xorg or better still Mesa, rather than waiting for a full stable 
release?  That would probably be the biggest help - by comparison kernel 
releases are very frequent.

Keith

