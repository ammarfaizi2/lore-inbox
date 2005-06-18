Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVFRS1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVFRS1v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 14:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVFRS1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 14:27:49 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:54661 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262174AbVFRS01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 14:26:27 -0400
Subject: Re: Linux 2.6.12
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0506172156220.7916@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506172156220.7916@ppc970.osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 18 Jun 2005 14:26:15 -0400
Message-Id: <1119119175.6786.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 22:13 -0700, Linus Torvalds wrote:
> As some people may have noticed already, 2.6.12 is out there now.

I just downloaded it, copied my 2.6.11.2 config over and did a make
oldconfig.  On USB Mon I got the following in the help.

-------------
If you say Y here, a component which captures the USB traffic
between peripheral-specific drivers and HC drivers will be built.
The USB_MON is similar in spirit and may be compatible with Dave
Harding's USBMon.

This is somewhat experimental at this time, but it should be safe,
as long as you aren't building this as a module and then removing it.

If unsure, say Y. Do not say M.

  USB Monitor (USB_MON) [M/n/?] (NEW)
--------------

I really like my options. :-)

OK, I have CONFIG_USB as a module, but I really thought that this was
pretty amusing.

-- Steve



