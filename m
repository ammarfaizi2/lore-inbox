Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316783AbSF0L3S>; Thu, 27 Jun 2002 07:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSF0L3R>; Thu, 27 Jun 2002 07:29:17 -0400
Received: from oak.sktc.net ([208.46.69.4]:19973 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S316783AbSF0L3R>;
	Thu, 27 Jun 2002 07:29:17 -0400
Message-ID: <3D1AF70B.7080501@sktc.net>
Date: Thu, 27 Jun 2002 06:29:15 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New Zaurus Wishlist - removable media handling
References: <Pine.LNX.3.96.1020627032159.2332J-100000@pioneer> 	<3D1A75FD.6010801@sktc.net> <1025165512.1078.91.camel@bip>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:

> timeouts are *evil*. 
> 

Since the PC has no way of knowing when you eject the disk (for 
floppies) you have to have a timeout, so that the data gets flushed.

For CD's you need a timeout to unlock the drive, otherwise the user hits 
the eject button and nothing happens - you have to unlock the drive for 
eject.

I'm not saying you automatically EJECT the disk - just unmount it, or 
mount it RO so that the user can remove it without harm.


