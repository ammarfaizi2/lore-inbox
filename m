Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268059AbUJCSm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268059AbUJCSm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268077AbUJCSkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:40:55 -0400
Received: from web11903.mail.yahoo.com ([216.136.172.187]:47640 "HELO
	web11903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268066AbUJCSin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:38:43 -0400
Message-ID: <20041003183839.36810.qmail@web11903.mail.yahoo.com>
Date: Sun, 3 Oct 2004 11:38:39 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: Merging DRM and fbdev
To: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@linux.ie>
Cc: dri-devel@lists.sf.net, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910410030833e8a6683@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about moving the DRM and FB specific code into there own per card
libs?

radeon - attached to hardware
   radeon-drm
      drm - library
   radeon-fb
      fb - library
         fbcon - library

Keeping in mind that any/all external symbols to/from radeon-drm and
radeon-fb can/should be weak.



	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
