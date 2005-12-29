Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVL2WsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVL2WsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 17:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVL2WsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 17:48:19 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:25254 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751068AbVL2WsT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 17:48:19 -0500
From: Ismail Donmez <ismail@uludag.org.tr>
Organization: TUBITAK/UEKAE
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
Date: Fri, 30 Dec 2005 00:47:47 +0200
User-Agent: KMail/1.9.1
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com>
In-Reply-To: <20051229224103.GF12056@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512300047.48159.ismail@uludag.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cuma 30 Aralık 2005 00:41 tarihinde, Dave Jones şunları yazmıştı: 
[...]
> The udev situation I mentioned has been known about for at least a month,
> probably longer. With old udev, we don't get /dev/input/event* created
> with 2.6.15rc.
>
> At some point in time it became defacto that certain things like udev,
> hotplug, alsa-lib, wireless-tools and a bunch of others have to have kept
> in lockstep with the kernel, and if it breaks, it's your fault for not
> upgrading your userspace.
>
> Seriously, I (and many others) have been complaining about this
> for months. (Pretty much every time the "Please can we have a 2.7"
> thread comes up). [note, that I actually prefer the 'new' approach
> to development in 2.6, what I object to is that at the same time we
> threw out the 'lets be careful about not breaking userspace' mantra.]
>
> Just a few years ago, if someone suggested breaking a userspace
> app in a kernel upgrade, they'd be crucified on linux-kernel, now
> it's 'the norm').

We had two userspace wireless monitoring program depending 
on /sys/class/net/<device name>/wireless directory to be present and now its 
gone in 2.6.15 and I can't find one line of changelog where its gone or 
why. /sys seems to be the mostly abused part of kernel-userspace relationship 
with changing paths,names and now disappearing directories....

Regards,
ismail
