Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUACMnL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 07:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbUACMnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 07:43:10 -0500
Received: from ns.suse.de ([195.135.220.2]:57473 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263472AbUACMms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 07:42:48 -0500
Date: Sat, 3 Jan 2004 13:42:16 +0100
From: Olaf Hering <olh@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Greg KH <greg@kroah.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040103124216.GA31006@suse.de>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <200401031151.02001.arvidjaar@mail.ru> <20040103133749.A3393@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040103133749.A3393@pclin040.win.tue.nl>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jan 03, Andries Brouwer wrote:

> On Sat, Jan 03, 2004 at 11:51:33AM +0300, Andrey Borzenkov wrote:
> 
> > yes. So what - how does it help? User needs /dev/sda4. User has /dev/sda only. 
> > Any attempt to refer to /dev/sda4 simply returns "No such file or directory"
> 
> Things are far from perfect here, but "blockdev --rereadpt /dev/sda" helps.

Is there really no way to get a media change notification from ZIP or
JAZ drives?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
