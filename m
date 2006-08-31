Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWHaU0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWHaU0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 16:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWHaU0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 16:26:37 -0400
Received: from hera.kernel.org ([140.211.167.34]:59059 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750810AbWHaU0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 16:26:37 -0400
Date: Thu, 31 Aug 2006 20:26:36 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.33.3
Message-ID: <20060831202636.GA26765@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This is the third version of 2.4.33-stable. The fix for the UDF deadlock
mentionned in previous announce has been merged, as well as the second
part of the SCTP fix. Other patches fix rather minor but annoying bugs.

Regards,
Willy

Summary of changes from v2.4.33.2 to v2.4.33.3
============================================

dann frazier:
      [SCTP] Fix sctp_primitive_ABORT() call in sctp_close()
      Fix possible UDF deadlock and memory corruption (CVE-2006-4145)

Jeff Mahoney:
      [DISKLABEL] SUN: Fix signed int usage for sector count

PaX Team:
      cciss: do not mark cciss_scsi_detect __init

Solar Designer:
      crypto : prevent cryptoloop from oopsing on stupid ciphers
      loop.c: kernel_thread() retval check

Willy Tarreau:
      Change VERSION to 2.4.33.3

