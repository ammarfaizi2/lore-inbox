Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263904AbTCXJpF>; Mon, 24 Mar 2003 04:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264041AbTCXJpF>; Mon, 24 Mar 2003 04:45:05 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:31246 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263904AbTCXJpE>;
	Mon, 24 Mar 2003 04:45:04 -0500
Date: Mon, 24 Mar 2003 01:55:47 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4-bk OHCI usb doesn't work
Message-ID: <20030324095547.GC5934@kroah.com>
References: <3E7E2FFC.9020304@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7E2FFC.9020304@walrond.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 10:06:52PM +0000, Andrew Walrond wrote:
> Nothing detected in dmesg. acpi enabled, same .config as with 2.4.20, 
> which works fine.

Are you trying to build the ohci driver into the kernel, and not as a
module?  I messed up the makefiles, and this isn't possible right now :(

thanks,

greg k-h
