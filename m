Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUAOUrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUAOUqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:46:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:40411 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263125AbUAOUod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:44:33 -0500
Date: Thu, 15 Jan 2004 12:40:48 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] sysfs class patch update [00/10]
Message-ID: <20040115204048.GA22199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 10 different patches, all against a clean 2.6.1.  They update
my previous sysfs class patches (and those should be dropped from the
existing -mm tree).  They fix the race condition in the previous ones,
and add new support for raw and lp devices.

Andrew, can you please add these patches to your -mm tree?  After some
testing there, I'll feel good enough to push them to Linus.

thanks,

greg k-h
