Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbTDGSpt (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTDGSpt (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:45:49 -0400
Received: from halo.ispgateway.de ([62.67.200.127]:15586 "HELO
	halo.ispgateway.de") by vger.kernel.org with SMTP id S263585AbTDGSps (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 14:45:48 -0400
Subject: Re: USB devices in 2.5.xx do not show in /dev
From: Jens Ansorg <jens@ja-web.de>
To: Greg KH <greg@kroah.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030407065101.GA20257@kroah.com>
References: <1049632582.3405.0.camel@lisaserver>
	 <20030406201638.GC18279@kroah.com> <1049696485.3321.16.camel@lisaserver>
	 <20030407065101.GA20257@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049741822.9495.3.camel@lisaserver>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 07 Apr 2003 20:57:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 08:51, Greg KH wrote:

> Sounds like you don't have a USB host controller driver getting loaded,
> right?  What does lsmod show?


yea!!! 
That's it!!!!

since the USB mouse basically worked I never thought that there is some
usb stuf missing ...

and of course the controler module got renamed from 2.4.xx :))

everything works now and my scroll wheel issue got also solved by
loading the host controller 


Can now use 2.5 as the default system. I need it because the wlan driver
seems much more stable than on my 2.4 system


thanks for the hints



-- 
Jens Ansorg <jens@ja-web.de>

