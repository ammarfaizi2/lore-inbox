Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284669AbRLZSEP>; Wed, 26 Dec 2001 13:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284676AbRLZSEE>; Wed, 26 Dec 2001 13:04:04 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:37643 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284669AbRLZSD4>;
	Wed, 26 Dec 2001 13:03:56 -0500
Date: Wed, 26 Dec 2001 10:03:53 -0800
From: Greg KH <greg@kroah.com>
To: Guido Guenther <agx@sigxcpu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17]: oops in usbcore during suspend
Message-ID: <20011226100353.D3460@kroah.com>
In-Reply-To: <20011223230723.GA1483@bogon.ms20.nix> <20011223184243.D5941@kroah.com> <20011226180021.A30644@galadriel.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011226180021.A30644@galadriel.physik.uni-konstanz.de>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 28 Nov 2001 15:10:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2001 at 06:00:21PM +0100, Guido Guenther wrote:
> Call Trace: [usbcore:usb_devfs_handle_Re9c5f87f+174345/197882743] [usbcore:usb_devfs_handle_Re9c5f87f+174855/197882233] [pci_pm_suspend_device+32/36] [pci_pm_suspend_bus+82/104] [pci_pm_suspend+35/68] 

These aren't valid symbols :)
It looks like something is messing with your oops output before you run
it through ksymoops.  Can you take the raw values from 'dmesg'?

thanks,

greg k-h
