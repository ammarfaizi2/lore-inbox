Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282062AbRK0RzA>; Tue, 27 Nov 2001 12:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282178AbRK0Ryr>; Tue, 27 Nov 2001 12:54:47 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:15876 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S282062AbRK0Rye>;
	Tue, 27 Nov 2001 12:54:34 -0500
Date: Tue, 27 Nov 2001 10:50:56 -0800
From: Greg KH <greg@kroah.com>
To: Samuel Maftoul <maftoul@esrf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ieee1394
Message-ID: <20011127105056.A9937@kroah.com>
In-Reply-To: <20011127144900.A21231@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011127144900.A21231@pcmaftoul.esrf.fr>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 30 Oct 2001 16:46:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 02:49:00PM +0100, Samuel Maftoul wrote:
> The second problem I have is:
> I don't really understand what for is the hotplug ? can It automatically
> mount any new firewire disk I plugged ? How should I do it?
> Does someone have a sample script which does  something like:
> fdisk -l /dev/$justplugged | awk ... | grep ... ; for i in
> $mountabledevices ; do mkdir /mnt/$cnt ; mount ... ; done 
> ( I hope you got what I'm searching for.)

The linux-hotplug package doesn't directly allow you to do automatic
mounts of filesystems that are plugged in, but it could :)

Right now it's focusing on automatically loading the proper kernel
driver for any device that has been plugged in.  See the
http://linux-hotplug.sf.net/ site for more docs on it.

thanks,

greg k-h
