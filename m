Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTLDAE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTLDAE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:04:29 -0500
Received: from c06284a.rny.bostream.se ([217.215.27.171]:16653 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S262882AbTLDAE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:04:28 -0500
From: Fredrik Tolf <fredrik@dolda2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16334.31260.278243.22272@pc7.dolda2000.com>
Date: Thu, 4 Dec 2003 01:04:44 +0100
To: linux-kernel@vger.kernel.org
Subject: Why is hotplug a kernel helper?
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you don't mind me asking, I would like to know why the kernel calls
a usermode helper for hotplug events? Wouldn't a chrdev be a better
solution (especially considering that programs like magicdev could
listen in to it as well)? Correct me if I'm wrong, but the kobject
code never does check the return value from the usermode helper,
right?

Fredrik Tolf

