Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTKPTcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 14:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTKPTcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 14:32:47 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:20999 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262321AbTKPTcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 14:32:46 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Is initramfs freed after kernel is booted?
Date: Sun, 16 Nov 2003 20:09:52 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311162009.52813.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently not:

{pts/1}% head -2 /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / reiserfs rw 0 0

at least it is still mounted. Is there any way to free it?

TIA

-andrey

