Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWDVTli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWDVTli (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWDVTli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:41:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:264 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750714AbWDVTlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:41:37 -0400
Date: Sat, 22 Apr 2006 20:41:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: fs/splice.c:286: warning: comparison of distinct pointer types lacks a cast
Message-ID: <20060422194131.GA4133@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/splice.c: In function '__generic_file_splice_read':
fs/splice.c:286: warning: comparison of distinct pointer types lacks a cast

seems to be a warning from min(), so is potentially a bug.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
