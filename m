Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293195AbSBWUTI>; Sat, 23 Feb 2002 15:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293196AbSBWUSr>; Sat, 23 Feb 2002 15:18:47 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:3603 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293195AbSBWUSh>;
	Sat, 23 Feb 2002 15:18:37 -0500
Date: Sat, 23 Feb 2002 12:12:48 -0800
From: Greg KH <greg@kroah.com>
To: David Stroupe <dstroupe@keyed-upsoftware.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Q:Resetting driver from within
Message-ID: <20020223201248.GA13779@kroah.com>
In-Reply-To: <3C766728.1050702@keyed-upsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C766728.1050702@keyed-upsoftware.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 26 Jan 2002 18:08:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 09:43:36AM -0600, David Stroupe wrote:
> 
> If I need to reset my driver and have it reprobe the pci bus under 
> software control, can I call the init and exit functions directly?

"reprobe" as in rescan the whole bus and add or remove devices?
If so, see the driver that I posted a week or so ago to the
linux-hotplug-devel mailing list.

If not, can you describe what you want to do in more detail?

thanks,

greg k-h
