Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTAOHxY>; Wed, 15 Jan 2003 02:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbTAOHxY>; Wed, 15 Jan 2003 02:53:24 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21002 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265815AbTAOHxY>;
	Wed, 15 Jan 2003 02:53:24 -0500
Date: Wed, 15 Jan 2003 00:02:01 -0800
From: Greg KH <greg@kroah.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb mouse and 2.5.56bk
Message-ID: <20030115080201.GF20302@kroah.com>
References: <200212141215.49449.tomlins@cam.org> <200301122242.01033.tomlins@cam.org> <20030114012319.GD10764@kroah.com> <200301140844.17839.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301140844.17839.tomlins@cam.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 08:44:17AM -0500, Ed Tomlinson wrote:
> 
> I used tar on my sysfs mount point (this did not work cleanly...) and have
> attached the tar and the dmesg log from the boot.  The last message in
> the log, which is from hid, was produced after the tar, when I replugged
> the mouse.
> 
> Kernel is now 2.5.58.

Ok, I think I've duplicated this here, and have a patch from Pat Mochel
that might fix it, but need to test.  I'll let you know what I find (if
you want, go add a bug at bugme.osdl.org for this to get updates on the
status of this problem.)

thanks,

greg k-h
