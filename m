Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVLATV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVLATV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVLATV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:21:26 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:44521 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932404AbVLATVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:21:25 -0500
Subject: mousedev auto load on 2.6.14-rc{2,3}
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 14:20:18 -0500
Message-Id: <1133464818.7130.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using the same config between 2.6.14 and 2.6.15-rc2 (and with rc3,
haven't tried rc4). The mousedev gets auto loaded on 2.6.14 but does not
with 2.6.15-rc{2,3}.  Did something change to prevent the auto loading
of mousedev?

So on 2.6.14, the X server starts without a problem on boot up.  But now
on 2.6.15-rc2 it doesn't (missing mouse pointer).  Yes I know that I can
add this to the modules.conf file, but I'm curious to what changed.

I'm using Debian/unstable.

-- Steve


