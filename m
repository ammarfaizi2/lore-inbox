Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTICMi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTICMi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:38:59 -0400
Received: from fastlane-28a.zyb.citynet.pl ([212.244.10.137]:16374 "EHLO
	moria.telperion.pl") by vger.kernel.org with ESMTP id S262037AbTICMi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:38:58 -0400
From: Marek Zachara <Marek.Zachara@telperion.pl>
Organization: Telperion
To: linux-kernel@vger.kernel.org
Subject: Small mistake in 2.6.0-test4 headers
Date: Wed, 3 Sep 2003 14:37:49 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031437.50014.Marek.Zachara@telperion.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to compile alsa driver I have found there is a small
mistake in the kernel headers. the file irq.h located in
/usr/src/linux/include/asm-i386 tries to include "irq_vectors.h". 
this fails since as I have noticed these machine specific files
have been moved to subdirectories (machine-default, etc.)
I am using a standard PC box.

hope it helps,
Marek

