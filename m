Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVFTJgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVFTJgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 05:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVFTJgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 05:36:47 -0400
Received: from smtpout1.BAYAREA.NET ([209.128.95.10]:49034 "EHLO
	smtpout1.bayarea.net") by vger.kernel.org with ESMTP
	id S261298AbVFTJgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 05:36:42 -0400
Message-ID: <42B68DFB.8090608@bayarea.net>
Date: Mon, 20 Jun 2005 10:35:55 +0100
From: Robert Gadsdon <rgadsdon@bayarea.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050415
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.12 kernel panic after loading promise_sata module
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried 2.6.12 (vanilla) kernel, and had the following at boot:
(typed from screen)
.............
Starting balanced_irq
Freeing unused kernel memory: 220k freed
Red Hat nash version 4.1.18 starting
Mounted /proc filesystem
Mounting sysfs
input: AT Translated set 2 keyboard on isa0060/serio0
Creating /dev
Starting udev
Loading libata.ko module
Loading sata_promise.ko module
Creating root device
Mounting root filesystem
mount: error 6 mounting ext3
mount: error 2 mounting none
Switching to new root
switchroot: mount failed: 22
umount /initrd/dev failed: 2
kernel panic - not syncing: Attempted to kill init!

   -

Reverted to 2.6.11.11 and everything worked OK.

UDEV version is 058

SATA controller card (from lspci):
00:12.0 Unknown mass storage controller: Promise Technology, Inc. 
PDC20318 (SATA150 TX4) (rev 02)

gcc version is 3.4.4


Robert Gadsdon
