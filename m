Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbSL0Cit>; Thu, 26 Dec 2002 21:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264760AbSL0Cit>; Thu, 26 Dec 2002 21:38:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36102 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264755AbSL0Cir>;
	Thu, 26 Dec 2002 21:38:47 -0500
Date: Thu, 26 Dec 2002 18:42:50 -0800
From: Greg KH <greg@kroah.com>
To: lvm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] [PATCH] allow dm-ioctl.ko to be used
Message-ID: <20021227024250.GE9549@kroah.com>
References: <20021220224148.GA13612@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220224148.GA13612@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 02:41:49PM -0800, Greg KH wrote:
> I guess no one runs the dm code as a module :)
> 
> Here's a small patch that allows dm-ioctl.ko to be loaded.  It is
> against the latest 2.5.52-bk tree.  Joe, please add this to the next set
> of patches you send out.

Ok, seems that dm-ioctl only gets built as a stand alone module with the
"testing" patches on Joe's web site, that's why no one else was having
this problem :)

Joe, if you want to add this patch, please do, but I now realize that it
isn't necessary for people to use the in-kernel version of dm right now.

thanks,

greg k-h
