Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUGLXDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUGLXDC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUGLXDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:03:02 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:21168 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S264147AbUGLXDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:03:00 -0400
Subject: Cisco aironet funnies
From: Dax Kelson <dax@gurulabs.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: breed@users.sourceforge.net
Content-Type: text/plain
Message-Id: <1089673389.3860.4.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 12 Jul 2004 17:03:10 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing PCMCIA Cisco Aironet 350 funnies that have been
verified on two different cards on two different laptops running FC2
both the stock FC2 kernels and with 2.6.7-mm[567].
                                                                                               
The two funnies I'm seeing:
                                                                                                                                                                                           
* Running "iwconfig eth1 mode Managed" *before* setting the ESSID and
wep key results in an inability to associate. If that command isn't run,
then everything is OK.
                                                                                               
* Doing a insert/eject loop, and running "iwconfig eth1" after each
insert will quickly result in a hang (and unkillable state) of the
iwconfig command.

Dax Kelson

