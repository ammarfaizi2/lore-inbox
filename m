Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVBWFAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVBWFAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 00:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVBWFAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 00:00:34 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:35984 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261189AbVBWFA3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 00:00:29 -0500
Subject: Warning of redefined NR_OPEN
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 06:00:28 +0100
Message-Id: <1109134828.8506.118.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when compiling the latest 2.6 tree from the Bitkeeper repository, I get
a lot of these:

  CC      init/main.o
In file included from include/linux/fs.h:202,
                 from include/linux/proc_fs.h:6,
                 from init/main.c:17:
include/linux/limits.h:4:1: warning: "NR_OPEN" redefined
In file included from include/linux/proc_fs.h:6,
                 from init/main.c:17:
include/linux/fs.h:24:1: warning: this is the location of the previous definition

Maybe the re-order of <linux/fs.h> to make userland happy was not a good
idea.

Regards

Marcel


