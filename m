Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVHNImi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVHNImi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 04:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVHNImh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 04:42:37 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:7629 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932153AbVHNImh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 04:42:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: usb camera failing in 2.6.13-rc6
Date: Sun, 14 Aug 2005 18:42:12 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <mailman.1124005092.8274.linux-kernel2news@redhat.com> <20050814010047.4b5fd37e.zaitcev@redhat.com>
In-Reply-To: <20050814010047.4b5fd37e.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508141842.13209.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005 18:00, Pete Zaitcev wrote:
> On Sun, 14 Aug 2005 17:12:06 +1000, Con Kolivas <kernel@kolivas.org> wrote:
> > A digital camera which was working fine in 2.6.11/12 now fails on
> > 2.6.13-rc6 (not sure when it started failing).
>
> Does it continue to work on an older kernel? I saw a USB device breaking
> right in the moment of reboot into a new kernel (thus prompting a week
> of diffing an head-scratching).

Yes all those dmesgs etc were redone after it failed in rc6 as I needed it 
working. Oh and all other usb devices - mouse, printer, scanner, keyboard are 
working fine in rc6; it's just the camera.

> > +usbmon: debugs is not available
>
> Deconfigure CONFIG_USB_MON. It's useless without debugfs anyway.

Will do,

Thanks
Con
