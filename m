Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVLOV0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVLOV0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVLOV0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:26:38 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:38173 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1751112AbVLOV0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:26:37 -0500
Date: Thu, 15 Dec 2005 22:26:35 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Olof Johansson <olof@lixom.net>
Cc: dtor_core@ameritech.net, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch driver
Message-ID: <20051215212635.GA6195@hansmi.ch>
References: <20051213223659.GB20017@hansmi.ch> <1134568620.3875.6.camel@localhost> <20051214213923.GB17548@hansmi.ch> <d120d5000512141404wc86331fo124ebd29b713b07e@mail.gmail.com> <20051214233108.GA20127@hansmi.ch> <20051215195017.GA7195@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215195017.GA7195@pb15.lixom.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 11:50:17AM -0800, Olof Johansson wrote:
> I think I agree with previous comments regarding debug code in the driver:
> It's unlikely to ever be used by more than a couple of people at very
> rare occasions (new hardware releases), and the barrier to using it is
> still high; new users need to learn how to parse the data anyway. I don't
> see a reason to include this in mainline.

Okay, based on your comments, please drop that patch. How about the one
to support the Geyser 2 device? Should I do a rediff without relayfs
support?

Greets,
Michael
