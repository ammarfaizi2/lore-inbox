Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbUCZO1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 09:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbUCZO1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 09:27:53 -0500
Received: from pri-dns.cs.iitm.ernet.in ([202.141.25.89]:31917 "EHLO
	cello.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S262797AbUCZO1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 09:27:51 -0500
To: linux-kernel@vger.kernel.org
Subject: Patching a proprietary driver
From: Rajsekar <raj.rspam.sekar@peacock.iitm.ernet.in>
Date: Fri, 26 Mar 2004 19:19:31 +0530
Message-ID: <y49lllnzpjo.fsf@sahana.cs.iitm.ernet.in>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a PCTEL Modem that works in 2.4.x with the proprietary drivers.

I have upgraded to 2.6.4 and there is no working driver for 2.6.x. A site
offers a driver that compiles (without using kmod type make files) but it
does not get loaded. (My guess is because he does not run modpost which the
kernel make scripts do).

I used kmod makefiles and have set it up properly but:

The problem is that some of their proprietary files (dsp.a, etc.) are
required by the module and when I compile it gives a warning like this:

warning: <filename> has a COMMON symbol.

Can someone help me overcome this?

I compiled at home and now am in office. Thus I can't provide you the exact
message.

-- 
   M Rajsekar
   IIT Madras
   Remove .rspam. to send mails.

