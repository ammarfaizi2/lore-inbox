Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVJKBcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVJKBcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 21:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVJKBcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 21:32:17 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:36314 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751319AbVJKBcQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 21:32:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IewAr0VhFsWIyyjEqtfgjfBDtHNqcf0RZN0wvRADcIXk0gPvpOvYP3ndUO4+UOzfaBLihuN3l4NAHsWOO8TtS2xqPHSCIiuOwoTTbmH+kJZnLfU1WGAZQY7XrhLNQCcxDgA7vU+gvuKcpfVQXpjyPXcZcEXEjOp6iMQWyAW+wiM=
Message-ID: <5bdc1c8b0510101832v5f0c80d0ldec1ade4d4530292@mail.gmail.com>
Date: Mon, 10 Oct 2005 18:32:15 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Robert Crocombe <rwcrocombe@raytheon.com>
Subject: Re: PS/2 Keyboard under 2.6.x
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <434B121A.3000705@raytheon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <434B121A.3000705@raytheon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Robert Crocombe <rwcrocombe@raytheon.com> wrote:
>
> I have a Microway system based around the Tyan Thunder K8QS Pro
> motherboard (4x Opterons).  Under recent versions of 2.6:
>
> 2.6.12
> 2.6.13
> 2.6.13.3
> 2.6.14-rc3-rt13
>
> the PS/2-connected keyboard becomes unresponsive once the kernel has
> booted (I can use it to select which kernel to boot in grub -- actually,
> it must be present to keep the system from whining and asking me to
> press F1).  A USB keyboard works (I am composing this message from the
> affected machine).  I attempted using earlier versions of the kernel,
> but they do not compile before 2.6.12, and if you go far enough back
> 'make menuconfig' doesn't work (I found and fixed the minor error that
> was reported, but haven't attempted to build those kernels again).
>

I just reported this problem on the Gentoo bugzilla a couple of days
ago. Here I have a P4HT machine. I had never turned on SMP to use the
hyperthreading feature. When I turned it on I got exactly the problem
you talk about. When I went back to UMP it worked fine.

My keyboard is a wireless thing that had a little dongle to make it
into ps2. I took that off and used the keyboard as a USB keyboard and
it works fine under SMP.

This was on 2.6.13-gentoo-r3 for me.

- Mark
