Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317504AbSGXSsG>; Wed, 24 Jul 2002 14:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317505AbSGXSsG>; Wed, 24 Jul 2002 14:48:06 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:24583 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317504AbSGXSsF>;
	Wed, 24 Jul 2002 14:48:05 -0400
Date: Wed, 24 Jul 2002 11:51:05 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] agpgart changes for 2.5.27
Message-ID: <20020724185105.GA10897@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Seems that some people think that I'm the person to send agpgart patches
to as I touched it last, when will I ever learn...

Here's a named initializer patch from Rusty for the agpgart code.

Pull from:  http://linuxusb.bkbits.net/agpgart-2.5

thanks,

greg k-h

------
ChangeSet@1.641, 2002-07-24 09:59:20-07:00, rusty@rustcorp.com.au
  [PATCH] AGP designated initializer update.
  
  The old form of designated initializers are obsolete: we need to
  replace them with the ISO C forms before 2.6.  Gcc has always supported
  both forms anyway.

 drivers/char/agp/agp.c      |  742 ++++++++++++++++++++++----------------------
 drivers/char/agp/frontend.c |   16 
 drivers/char/agp/i460-agp.c |    4 
 3 files changed, 381 insertions(+), 381 deletions(-)
------

