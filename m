Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUABUXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUABUXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:23:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:39301 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265654AbUABUXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:23:38 -0500
Date: Fri, 2 Jan 2004 12:23:16 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev - please help me to understand
Message-ID: <20040102202316.GD4992@kroah.com>
References: <microsoft-free.87r7yiinaj.fsf@eicq.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <microsoft-free.87r7yiinaj.fsf@eicq.dnsalias.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 09:48:36PM +1000, Steve Youngs wrote:
> Hi Greg!
> 
> I've been looking at this "udev" thingy and I can't for the life of me
> see why I'd need it.  There doesn't appear to be _any_ advantages of
> using udev in my present situation.

Ok, great.  Then don't use it, I'm not forcing you to for 2.6 :)

> No, I don't use devfs.
> 
> I have zero hot-pluggable devices (that might change somewhere in the
> distant future, but for now I don't have any).  And never in my wildest
> dreams could I ever imagine running out of device numbers.
> 
> Reading through the documentation that I've found about udev, your
> main points seem to be about:
> 
>         - udev vs devfs
>         - running out of device major/minor numbers
>         - not having to worry about major/minor numbers
> 
> For me, the first point is moot because I don't use devfs.  The second
> point is just plain ridiculous, there is just _no_ way that it could
> happen (remember that I'm talking about my own situation).  

If you never have any hotpluggable devices, nor any need to move disks
around in your system, then you don't need udev.

Hope this helps,

greg k-h
