Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUACMhz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 07:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUACMhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 07:37:55 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:51462 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262048AbUACMhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 07:37:53 -0500
Date: Sat, 3 Jan 2004 13:37:49 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040103133749.A3393@pclin040.win.tue.nl>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <200401031151.02001.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200401031151.02001.arvidjaar@mail.ru>; from arvidjaar@mail.ru on Sat, Jan 03, 2004 at 11:51:33AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 11:51:33AM +0300, Andrey Borzenkov wrote:

> yes. So what - how does it help? User needs /dev/sda4. User has /dev/sda only. 
> Any attempt to refer to /dev/sda4 simply returns "No such file or directory"

Things are far from perfect here, but "blockdev --rereadpt /dev/sda" helps.

