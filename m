Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVCPAdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVCPAdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVCPAdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:33:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:13755 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262190AbVCPAcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:32:48 -0500
Date: Tue, 15 Mar 2005 16:22:22 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: chrisw@osdl.org, torvalds@osdl.org, akpm@osdl.org
Subject: Linux 2.6.11.4
Message-ID: <20050316002222.GA30602@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've release 2.6.11.4 with two security fixes in it.  It can be found at
the normal kernel.org places.

The diffstat and short summary of the fixes are below.  

I'll also be replying to this message with a copy of the patch between
2.6.11.3 and 2.6.11.4, as it is small enough to do so.

thanks,
 
greg k-h

------
 Makefile                |    2 +-
 drivers/net/ppp_async.c |    2 +-
 fs/exec.c               |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


Summary of changes from v2.6.11.3 to v2.6.11.4
==============================================

Greg Kroah-Hartman:
  o Linux 2.6.11.4

Paul Mackerras:
  o CAN-2005-0384: Remote Linux DoS on ppp servers

Prasanna Meda:
  o use strncpy in get_task_comm

