Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbTHULik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 07:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbTHULik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 07:38:40 -0400
Received: from law14-f60.law14.hotmail.com ([64.4.21.60]:32012 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262618AbTHULij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 07:38:39 -0400
X-Originating-IP: [194.85.81.178]
X-Originating-Email: [john_r_newbie@hotmail.com]
From: "John Newbie" <john_r_newbie@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Maybe remove request_module("scsi_hostadapter"); from ->
Date: Thu, 21 Aug 2003 15:38:38 +0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law14-F60elXDeqoMIO000010f9@hotmail.com>
X-OriginalArrivalTime: 21 Aug 2003 11:38:38.0409 (UTC) FILETIME=[C352DB90:01C367D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/scsi.c ?
The main purpose of it is just adding error messages to dmesg, like this one

kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2

I saw this on most ide-based boxes.
The reason is that scsi subsystem starts before mounting
root FS, so where we can get modules.conf and insmod ?

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

