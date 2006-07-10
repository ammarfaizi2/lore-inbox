Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161287AbWGJB37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161287AbWGJB37 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 21:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWGJB37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 21:29:59 -0400
Received: from gw.goop.org ([64.81.55.164]:54994 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964976AbWGJB37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 21:29:59 -0400
Message-ID: <44B1AD95.8040703@goop.org>
Date: Sun, 09 Jul 2006 18:29:57 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1:  /sys/class/net/ethN becoming symlink befuddled
 /sbin/ifup
References: <20060709021106.9310d4d1.akpm@osdl.org>	<1152469329.9254.15.camel@Homer.TheSimpsons.net> <20060709135148.60561e69.akpm@osdl.org>
In-Reply-To: <20060709135148.60561e69.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I'd be suspecting
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/broken-out/gregkh-driver-network-class_device-to-device.patch.
>
> If you could do a `patch -R' of that one it'd really help, thanks.
This broke gnome NetworkManager as well.  Reverting the two patches 
makes it happy.

    J
