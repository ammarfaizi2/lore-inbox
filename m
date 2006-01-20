Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161118AbWATEFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbWATEFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 23:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161481AbWATEFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 23:05:05 -0500
Received: from [205.233.219.253] ([205.233.219.253]:55754 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1161118AbWATEFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 23:05:04 -0500
Date: Thu, 19 Jan 2006 23:03:27 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] update the i386 defconfig
Message-ID: <20060120040326.GF13178@conscoop.ottawa.on.ca>
References: <20060119201046.GY19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119201046.GY19398@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 09:10:46PM +0100, Adrian Bunk wrote:
> [...]
>  #
>  # IEEE 1394 (FireWire) support
>  #
> -CONFIG_IEEE1394=y

Boo.  1394 good.  I suggest the above plus:

CONFIG_IEEE1394_SBP2=y
CONFIG_IEEE1394_RAWIO=y

Cheers,
Jody
