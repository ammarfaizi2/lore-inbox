Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUFJRlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUFJRlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 13:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUFJRlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 13:41:24 -0400
Received: from web20209.mail.yahoo.com ([216.136.226.64]:59917 "HELO
	web20209.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262109AbUFJRlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 13:41:22 -0400
Message-ID: <20040610174121.9243.qmail@web20209.mail.yahoo.com>
Date: Thu, 10 Jun 2004 10:41:21 -0700 (PDT)
From: Raghava Vatsavayi <rajuraghava@yahoo.com>
Subject: register_netdev usage
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please clarify any issues with “register_netdev”
usage. Like I have seen strange behaviour with 2.6.5-7
kernel on PPC64 platform in my network driver:

When “register_netdev” is not called at the end of my
probe function “s2io_init_nic”  but some where in
middle of probe function, then s2io_open gets called
even though I was just doing insmod. But this issue
goes away when I push register_netdev to the end of
probe function.

So why is it like this, is this expected behaviour???

Please mail me at rajuraghava@yahoo.com as I did’t
subscribe.

Regards
Raghava.



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
