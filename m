Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268854AbUJUJLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268854AbUJUJLO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269079AbUJTSyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:54:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:56235 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269078AbUJTSyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:54:00 -0400
Date: Wed, 20 Oct 2004 20:53:55 +0200
From: Olaf Hering <olh@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: get a pointer to $(obj)/../../include/asm/byteorder.h
Message-ID: <20041020185355.GA11861@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

drivers/atm/Makefile looks a bit messy..

Is there a way to get $(obj)/include2/asm/byteorder.h?
make all O=$foo fails to set the correct byteorder for
CONFIG_ATM_FORE200E_PCA_FW when CONFIG_ATM_FORE200E_PCA_DEFAULT_FW is
set.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
