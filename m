Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVLIAG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVLIAG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 19:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbVLIAG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 19:06:58 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:58282 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932120AbVLIAG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 19:06:58 -0500
Subject: Re: for_each_online_cpu broken ?
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Dave Jones <DaveJ@redhat.com>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051208062844.GF28201@redhat.com>
References: <20051208050738.GE24356@redhat.com>
	 <20051208052632.GF11190@wotan.suse.de> <20051208053302.GA28201@redhat.com>
	 <1134022925.7235.28.camel@localhost>  <20051208062844.GF28201@redhat.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1134076293.7235.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 09 Dec 2005 10:03:30 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-12-08 at 16:28, Dave Jones wrote:
> On Thu, Dec 08, 2005 at 04:22:05PM +1000, Nigel Cunningham wrote:
> 
>  > > Yep, I noticed it offers a maximum of 6 cpus on my way.
>  > > As a sidenote, seems kinda funny (and wasteful maybe?), doing this
>  > > on a lot of hardware that isn't hotplug capable. (Whilst I could
>  > > disable cpu hotplug in my local build, this isn't an answer for
>  > > a generic distro kernel).
>  > 
>  > Both suspend to disk (and suspend to ram?) implementations now depend on
>  > hotplug_cpu to enable extra cpus, so there is at least one reason for
>  > them to want hotplug support in a generic kernel.
> 
> You mean suspend -> plug in a new cpu -> resume transitions ?
> That sounds *terrifying*.

Andi is right, it's just a logical unplug. But having said that, I
suppose extra cpus could be plugged/unplugged during a suspend to disk.
Not that I've ever tried it. I have a real SMP mobo, but haven't had the
opportunity to fire it up.

Regards,

Nigel

