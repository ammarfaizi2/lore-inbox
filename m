Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbUCTM6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 07:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUCTM6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 07:58:18 -0500
Received: from smtp01.web.de ([217.72.192.180]:28934 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263393AbUCTM6R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 07:58:17 -0500
From: Pascal Maillard <pascalmaillard@web.de>
To: linux-kernel@vger.kernel.org
Subject: independence from ide master/slave
Date: Sat, 20 Mar 2004 13:53:18 +0100
User-Agent: Dei Mudda sei Gsischt
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403201353.18841.pascalmaillard@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

recently, I had changed my IDE disk from primary master to slave. I've got 
SUSE, Debian and Windows XP installed on it. I was ashamed to see that 
Windows loaded immediately, but the Linuxes didn't, because all of the 
filesystems were thought to be on /dev/hda. So I asked myself if there should 
not be device files that point to the _current_ hard disk (which should be 
defined at startup by the kernel) and its partitions. This way, it wouldn't 
matter which IDE channel a disk is connected to. What do you mean about this?

Please cc me!

cö,
Pascal Maillard
