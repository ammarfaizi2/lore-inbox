Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263335AbUEBWSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbUEBWSw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 18:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbUEBWSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 18:18:52 -0400
Received: from ptb-relay01.plus.net ([212.159.14.212]:17682 "EHLO
	ptb-relay01.plus.net") by vger.kernel.org with ESMTP
	id S263335AbUEBWSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 18:18:51 -0400
Message-ID: <409573CC.1000700@mauve.plus.com>
Date: Sun, 02 May 2004 23:18:52 +0100
From: Ian Stirling <linux-kernel@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: usb-storage unplanned unplugging. (2.6.5)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What should happen when I unplug a USB-storage device with mounted filesystems
that are in use?


At the moment, it simply kills the USB port that it's on, it won't recognise
anything plugged into it later.
Sort-of understandably, the scsi-module won't now unload, nor will the usb-storage
or USB ones.

Obviously, this isn't intentional, but my MP3 player has a very badly designed
connector.
