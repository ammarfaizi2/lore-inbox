Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbTCZSnX>; Wed, 26 Mar 2003 13:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbTCZSnX>; Wed, 26 Mar 2003 13:43:23 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56837 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261872AbTCZSnU>;
	Wed, 26 Mar 2003 13:43:20 -0500
Date: Wed, 26 Mar 2003 10:53:41 -0800
From: Greg KH <greg@kroah.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: fixing module autoload stacking
Message-ID: <20030326185341.GF24689@kroah.com>
References: <20030326144526.GD2328@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326144526.GD2328@rdlg.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 09:45:26AM -0500, Robert L. Harris wrote:
> 
> 
> Ok, bringing this here because it's bugging a few of us.
> 
> Scenario:
>   Linux 2.4.X kernel with scsi-generic, usb-storage, fat and vfat compiled 
> as modules.  I plug in my usb drive (archos jukebox or sandisk
> thumbdrive) and it won't autoload the sg and usb-storage drivers.  If I
> modprobe sg, modprobe usb-drive it will autoload fat and vfat.
> 
>   What the heck do I need to change on my Debian system (I can try and
> convert redhat directions) to get this chain working properly?

Do you have the hotplug package installed?  It should handle this for
you.

thanks,

greg k-h
