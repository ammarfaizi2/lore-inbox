Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUIDRmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUIDRmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUIDRmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:42:15 -0400
Received: from the-village.bc.nu ([81.2.110.252]:49304 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264917AbUIDRmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:42:14 -0400
Subject: Re: New proposed DRM interface design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409041253390.25475@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
	 <Pine.LNX.4.58.0409040145240.25475@skynet>
	 <20040904102914.B13149@infradead.org>
	 <41398EBD.2040900@tungstengraphics.com>
	 <20040904104834.B13362@infradead.org>
	 <413997A7.9060406@tungstengraphics.com>
	 <20040904112535.A13750@infradead.org>
	 <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com>
	 <4139A9F4.4040702@tungstengraphics.com>
	 <20040904124658.A14628@infradead.org>
	 <Pine.LNX.4.58.0409041253390.25475@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094315965.10540.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 04 Sep 2004 17:39:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-04 at 13:04, Dave Airlie wrote:
> I've got nothing to do with Tungsten whatsoever, I've never met any of the
> other major DRI developers, my worries here is this is turning into a
> company issue, people keep mentioning Fedora this and that, Fedora is one
> distro, I happen to use it, lots of people I know dont.. it supports DRI
> on IGP and i915 in Fedora 3 Test only, a DRI snapshot works on FC1 and
> FC2 as well..

Fedora essentially solves the problem with regularly release cycles and
policy. So once we know 2.6.10 or whatever is stable we can push that
for FC2 and FC3. We can push Xorg for FC2 because its in the
distribution description. Same for Gentoo except they'll probably ship
it before Fedora does.

> Again what about distros that only do security upgrades in stable
> releases, I would like to give those people a chance to use their graphics
> cards, and the snapshots are not the only way, 

For these setups the snapshots work well because you can package up an
extra driver in the knowledge that the vendor isnt going to do something
"Neat". If you want i915 in RHEL3 then that would certainly be the path
to take for example.

Distribution policies in part dictate the method. It doesn't imply any
one distribution policy is somehow "right".

Alan

