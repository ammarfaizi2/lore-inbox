Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbUDNBNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 21:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUDNBNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 21:13:36 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:12550 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S263354AbUDNBNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 21:13:36 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200404140113.VAA15345@clem.clem-digital.net>
Subject: 2.6.5-bk1 and VMWare GSX 3
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Tue, 13 Apr 2004 21:13:34 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:
  The 2.6.5-bk1 breaks VMWare GSX 3 module compile.
  GSX 3 uses the kernel module build system.  Problem
  is that the .tmp_versions directory is not getting
  created in the VMWare module directory.  Complies
  fine after manually adding .tmp_version directory.
  Assume that the kernel build system is failing to
  create the directory?
-- 
Pete Clements 
