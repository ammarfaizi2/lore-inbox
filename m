Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266050AbUA1STd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 13:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUA1STd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 13:19:33 -0500
Received: from ns.suse.de ([195.135.220.2]:44191 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266050AbUA1ST0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 13:19:26 -0500
Date: Wed, 28 Jan 2004 19:01:11 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: some combinations of make targets do not work anymore
Message-ID: <20040128180111.GA23021@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stuff like that used to work with 2.4 kernels, 2.6.2-rc2-mm2 runs make
oldconfig and depmod, but 'all' and 'modules_install' is not executed.
Bug or feature? target is ppc32.

2.4:
/usr/bin/time make oldconfig dep zImage modules modules_install INSTALL_MOD_PATH=`pwd` 2>&1 | tee log
2.6
/usr/bin/time make oldconfig all modules_install INSTALL_MOD_PATH=`pwd` 2>&1 | tee log

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
