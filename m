Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264374AbTCXSvs>; Mon, 24 Mar 2003 13:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264380AbTCXSvr>; Mon, 24 Mar 2003 13:51:47 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:26127 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264374AbTCXSvp>;
	Mon, 24 Mar 2003 13:51:45 -0500
Date: Mon, 24 Mar 2003 11:02:24 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix usb_devfs_handle abuse
Message-ID: <20030324190224.GL8194@kroah.com>
References: <20030324184306.A10101@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324184306.A10101@lst.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 06:43:06PM +0100, Christoph Hellwig wrote:
> Many usb drivers use the usb_devfs_handle variable instead of just
> adding the usb/ prefix directly to their devfs_register calls.  Fix
> that and make usb_devfs_handle static and unexported.

Looks good to me.  If Linus doesn't add it to his tree, I'll add it to
mine, and send it to him in the next round of USB updates.

thanks,

greg k-h
