Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbUDOSfy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUDOScj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:32:39 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:24590 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S263725AbUDOScF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:32:05 -0400
Date: Thu, 15 Apr 2004 20:32:31 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: VIA Firewire still broken in 2.6.5 (also broken in 2.6.4, worked in 2.6.3)
Message-ID: <20040415183230.GA16458@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.4, the kernel would detect my cold plugged Maxtor disk, but then
freeze and eventually time out trying to mount the file system on it in
the boot process.

In 2.6.5, largely the same, but the kernel works when the disk is hot
plugged in after the boot process.  Having it plugged in during the boot
process still fails, and unplugging and replugging it after the boot
process still fails.

After a few write accesses on the file system, however, 2.6.5 panics.

Is this a known problem?  Anyone working on it?

Felix
