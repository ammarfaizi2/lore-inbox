Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266248AbUHORlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUHORlM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266708AbUHORlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:41:12 -0400
Received: from web14929.mail.yahoo.com ([216.136.225.94]:62305 "HELO
	web14929.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266248AbUHORlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:41:08 -0400
Message-ID: <20040815174108.14463.qmail@web14929.mail.yahoo.com>
Date: Sun, 15 Aug 2004 10:41:08 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: module parameters and 2.6 macros
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there some way to avoid two sets of parsing code with the 2.6 module
parameter macros?

With the new module parameter macros I can do this:
modprobe radeon debug=1 cards_limit=10

compiled in I need:
kernel /vmlinuz-2.6.8.1 radeon=debug:1,cards_limit:10

For the compiled in case the driver has a parser which decodes the
string. I'd like to remove this parser.

Is this what MODULE_SUPPORTED_DEVICE() is for but the code isn't
written yet?

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
