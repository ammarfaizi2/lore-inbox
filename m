Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWJDLiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWJDLiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030826AbWJDLiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:38:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:26021 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030825AbWJDLiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:38:15 -0400
Message-ID: <45239D1F.7060102@garzik.org>
Date: Wed, 04 Oct 2006 07:38:07 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Shaohua Li <shaohua.li@intel.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: drivers/base/sys.c bug found
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysdev_driver::add is defined to return an error (as it should), but 
that error code is never checked.

	Jeff


