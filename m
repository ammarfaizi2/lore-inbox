Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265527AbUAGN2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbUAGN2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:28:04 -0500
Received: from ns.suse.de ([195.135.220.2]:3274 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265527AbUAGN2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:28:01 -0500
Date: Wed, 7 Jan 2004 14:27:59 +0100
From: Olaf Hering <olh@suse.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Rob Love <rml@ximian.com>, Nathan Conrad <lk@bungled.net>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040107132759.GA6912@suse.de>
References: <E1AbWgJ-0000aT-00@neptune.local> <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur> <20031231220107.GC11032@bungled.net> <1072909218.11003.24.camel@fur> <20031231225536.GP4176@parcelfarce.linux.theplanet.co.uk> <20040107101559.GA22770@suse.de> <20040107111832.GL4176@parcelfarce.linux.theplanet.co.uk> <20040107130036.GA3186@suse.de> <20040107132656.GM4176@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040107132656.GM4176@parcelfarce.linux.theplanet.co.uk>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 07, viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Jan 07, 2004 at 02:00:36PM +0100, Olaf Hering wrote:
>  
> > Ok, it was mkfs.minix and an older distro.
> 
> mkfs should simply pass O_EXCL to open().  Which is what you really want
> and yes, it should work on 2.6 (not sure if it got backported on 2.4).

Thanks! I will play with it and see what current tools use.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
