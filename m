Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUIDXED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUIDXED (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 19:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUIDXED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 19:04:03 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:27851 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264299AbUIDXEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 19:04:01 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: multi-domain PCI and sysfs
Date: Sat, 4 Sep 2004 16:03:56 -0700
User-Agent: KMail/1.7
Cc: lkml <linux-kernel@vger.kernel.org>, willy@debian.org
References: <9e4733910409041300139dabe0@mail.gmail.com> <200409041527.50136.jbarnes@engr.sgi.com> <9e47339104090415451c1f454f@mail.gmail.com>
In-Reply-To: <9e47339104090415451c1f454f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041603.56324.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, September 4, 2004 3:45 pm, Jon Smirl wrote:
> Is this a multipath configuration where pci0000:01 and pci0000:02 can
> both get to the same target bus? So both busses are top level busses?
>
> I'm trying to figure out where to stick the vga=0/1 attribute for
> disabling all the VGA devices in a domain. It's starting to look like
> there isn't a single node in sysfs that corresponds to a domain, in
> this case there are two for the same domain.

Yes, I think that's the case.  Matthew would probably know for sure though.

Jesse
