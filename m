Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSIJBWZ>; Mon, 9 Sep 2002 21:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSIJBWZ>; Mon, 9 Sep 2002 21:22:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15367 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313113AbSIJBWY>; Mon, 9 Sep 2002 21:22:24 -0400
Date: Mon, 9 Sep 2002 18:27:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Nicholas Miell <nmiell@attbi.com>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <1031618129.1403.12.camel@entropy>
Message-ID: <Pine.LNX.4.44.0209091825390.1714-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Sep 2002, Nicholas Miell wrote:
> 
> show_trace isn't exported for modules, and (even worse) isn't even
> implemented on all architectures, IIRC.

So? If it is a problem for people, fix it. Or remove the damn call. It 
_still_ isn't valid to kill a machine for a non-fatal error.

We're not Windows. We don't take GFP's for random reasons. I'm not
interested in what some people call "hardening", but I _am_ interested in
a system that is rock solid and works even when it doesn't necessarily
expect to.

		Linus

