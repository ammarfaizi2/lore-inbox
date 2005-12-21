Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVLUW2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVLUW2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVLUW2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:28:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:56534 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964837AbVLUW2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:28:30 -0500
Date: Wed, 21 Dec 2005 14:27:43 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 0/2] 2 USB patches for 2.6.15
Message-ID: <20051221222743.GA9501@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 2 patches against your latest 2.6.15-git tree.  They fix the
following problems:
	- bugfix to allow some USB disk enclosure devices to work
	  properly.
	- small workaround to allow suspend to continue, even if the USB
	  driver attached to a device does not have a suspend method
	  (this preserves the old behavior, and is annoying a lot of
	  people.)

thanks,

greg k-h
