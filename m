Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbTBRFsF>; Tue, 18 Feb 2003 00:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267656AbTBRFsF>; Tue, 18 Feb 2003 00:48:05 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22285 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267641AbTBRFsF>;
	Tue, 18 Feb 2003 00:48:05 -0500
Date: Mon, 17 Feb 2003 21:51:25 -0800
From: Greg KH <greg@kroah.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] link error in usbserial with gcc3.2
Message-ID: <20030218055125.GA4927@kroah.com>
References: <3DF453C8.18B24E66@digeo.com> <3DF54BD7.726993D@digeo.com> <200302110813.18360.tomlins@cam.org> <200302112059.07685.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302112059.07685.tomlins@cam.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 08:59:07PM -0500, Ed Tomlinson wrote:
> I dug into this a bit more.  It would seem to be a compiler
> bug, where it tries to branch back 129 bytes...  I will report
> it using debian channels.
> 
> The following change will let things compile until gcc is fixed.

Thanks for finding this, but I don't think that work around is ok as
it's printing out something that isn't necessary :)

thanks,

greg k-h
