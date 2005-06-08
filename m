Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVFHA76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVFHA76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 20:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVFHA76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 20:59:58 -0400
Received: from femail.waymark.net ([206.176.148.84]:58555 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S262059AbVFHA74 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 20:59:56 -0400
Date: 8 Jun 2005 00:59:42 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: [ACPI] acpi_processor_set_power_policy
To: linux-kernel@vger.kernel.org
Message-ID: <a03f9a.c79f75@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# readprofile -r ; sleep 1 ; readprofile -m /boot/System.map | sort -nr

    527 total                                      0.0003
    502 acpi_processor_set_power_policy            2.6989
      7 sort                                       0.0208
      7 release_task                               0.0208
      4 zone_watermark_ok                          0.0208
      3 do_page_fault                              0.0021
      1 unmap_page_range                           0.0057
      1 show_free_areas                            0.0013
      1 do_file_page                               0.0048
      1 buffered_rmqueue                           0.0020

Should acpi_processor_set_power_policy be called this often?

Kernel: 2.6.12-rc5-git9  # define HZ    500  <include/asm-i386/param.h>
Computer: Cyrix MII and VIA MVP3, e-machines '99
dmesg..
Kernel command line: BOOT_IMAGE=2.6.12-rc5-git9 ro root=301 clock=tsc elevator=
 deadline lpj=376832 profile=2
 kernel profiling enabled (shift: 2)

More information and at request.

...  A:  6-1/2" x 6-1/2" x 2"   Q: How big is the Mac Mini?
--- MultiMail/Linux v0.46  [currently BlueWave packet type]
