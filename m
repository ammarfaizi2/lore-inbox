Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265132AbUD3QMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbUD3QMC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbUD3QL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:11:57 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:39300 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265131AbUD3QLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:11:00 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] 3 USB regressions (2.6.6-rc3-bk1) that should be fixed before 2.6.6
Date: Fri, 30 Apr 2004 18:10:56 +0200
User-Agent: KMail/1.5.4
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       speedtouch@ml.free.fr
References: <Pine.LNX.4.58.0404300113120.444@alpha.polcom.net> <200404300952.00454.baldrick@free.fr> <20040430155521.GA4463@kroah.com>
In-Reply-To: <20040430155521.GA4463@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404301810.56271.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Honestly, I don't see how some of these issues started showing up
> between those two kernel releases.  You can see the only changes made in
> the USB section broken out by patch at:
> 	kernel.org/pub/linux/kernel/people/gregkh/2.6/2.6.6-rc2/

Hi Greg, I'm not sure when these problems started showing up, maybe they
have been in 2.6.6- for a while.  One patch that may be worth having in 2.6.6
by the way is the one for device_disconnect in devio.c that changes
destroy_all_async to destroy_async_on_interface.  It's clearly correct and does
do some good!

Ciao,

Duncan.
