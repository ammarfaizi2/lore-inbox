Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268971AbUIQPxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268971AbUIQPxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268881AbUIQPv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:51:56 -0400
Received: from cantor.suse.de ([195.135.220.2]:49381 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268971AbUIQPsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:48:35 -0400
Date: Fri, 17 Sep 2004 17:43:46 +0200
From: Olaf Hering <olh@suse.de>
To: Randy Dunlap <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: kconfig: save kernel version in .config file
Message-ID: <20040917154346.GA15156@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Randy,

we need a way to turn the timestamp off when running make oldconfig.
Running make oldconfig gives always a delta, even if the .config is
unchanged. This is bad for cvs repos, it generates conflicts now if 2
people work on the same config file.
Please provide a patch to not call ctime if a non-empty enviroment
variable of your choice is set.

http://linux.bkbits.net:8080/linux-2.5/cset@411638e5ljptW-TmFM1SHBiIEg63OA

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
