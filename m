Return-Path: <linux-kernel-owner+w=401wt.eu-S1751678AbXANVCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbXANVCj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 16:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbXANVCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 16:02:38 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:45497 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbXANVCi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 16:02:38 -0500
From: Oliver Neukum <oliver@neukum.org>
To: icxcnika@mar.tar.cc, linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: usb somehow broken
Date: Sun, 14 Jan 2007 22:03:02 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0701141418290.24969-100000@netrider.rowland.org> <Pine.LNX.4.64.0701141945010.14767@server.willdawg>
In-Reply-To: <Pine.LNX.4.64.0701141945010.14767@server.willdawg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701142203.03306.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 14. Januar 2007 20:47 schrieb icxcnika@mar.tar.cc:
> > When the scanner is not in use, the system automatically suspends it after
> > two seconds.  When you use sane the scanner is resumed, but it then
> > disconnects itself and reconnects.  Sane is left trying to control the
> > disconnected device instance, so of course it fails.
> >
> > I'm beginning to think that we need some way to deal with devices that
> > cannot recover from a suspend.  Several examples have cropped up.
> > Unfortunately, I can't think of anything better than a blacklist, which is
> > not very satisfactory.
> >
> > Can anyone suggest another approach?
> >
> > Alan Stern
> 
> Just a thought, you could use both a blacklist approach, and a module 
> paramater, or something in sysfs, to allow specifying devices that won't 
> be suspend and resume compatible.

Yes,
but in any case the sysfs attributes would have to populated somehow.
You'd just shift the burden. As this behavior is hopefully rare, it's
probably not worth the effort.

I can't think of anything better than a blacklist.

	Regards
		Oliver
