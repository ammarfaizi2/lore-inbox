Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263469AbTCNThr>; Fri, 14 Mar 2003 14:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263474AbTCNThr>; Fri, 14 Mar 2003 14:37:47 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62989 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263469AbTCNThr>;
	Fri, 14 Mar 2003 14:37:47 -0500
Date: Fri, 14 Mar 2003 11:37:19 -0800
From: Greg KH <greg@kroah.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: Re: [2.4] Memleak in drivers/usb/hub.c::usb_reset_device
Message-ID: <20030314193718.GC7560@kroah.com>
References: <20030312194133.GA27968@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312194133.GA27968@linuxhacker.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 10:41:33PM +0300, Oleg Drokin wrote:
> Hello!
> 
>    There seems to be a memleak in drivers/usb/hub.c::usb_reset_device()
>    on error exit path. See the patch.
>    Found with help of smatch + enhanced unfree script.

Applied to my tree, thanks.

And yes, as David said, there is another kind of error in this area for
2.5.  Patches to clean that up would be appreciated.

thanks,

greg k-h
