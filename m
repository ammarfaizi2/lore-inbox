Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267468AbUBRPCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 10:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267473AbUBRPCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 10:02:04 -0500
Received: from dns.communicationvalley.it ([212.239.58.133]:8906 "HELO
	rose.communicationvalley.it") by vger.kernel.org with SMTP
	id S267468AbUBRPCB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 10:02:01 -0500
From: Silla Rizzoli <silla@netvalley.it>
Organization: Communication Valley spa
To: linux-kernel@vger.kernel.org
Subject: 2.6.3 radeon framebuffer problems
Date: Wed, 18 Feb 2004 16:01:54 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402181601.56209.silla@netvalley.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
the new radeon fb driver fails to clear the last console line after scrolling 
up the screen.
That means that my prompt, for example,
looks like the one pictured below

[ silla@mermaid ~ ]
$ _illa@mermaid ~ ]

instead of

[ silla@mermaid ~ ]
$ _

This only happens after exiting from Xfree (I'm currently running version 
4.3.0.1) and a quick fbset is enough to get the situation back to normal.
The old driver works fine, except for the garbled screen at boot up, but 
everybody already knows that.

Let me know if you need further information.

Regards,
Silla Rizzoli

