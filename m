Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135994AbRDTTrJ>; Fri, 20 Apr 2001 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135995AbRDTTq6>; Fri, 20 Apr 2001 15:46:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:15096 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S135994AbRDTTqq>; Fri, 20 Apr 2001 15:46:46 -0400
Message-ID: <3AE09225.A88ADD15@mvista.com>
Date: Fri, 20 Apr 2001 12:46:45 -0700
From: Brian Moyle <bmoyle@mvista.com>
Organization: MontaVista Software, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.3-ac10: sanitize_e820_map()
Content-Type: multipart/mixed;
 boundary="------------BBB48DE31E81124824B914AE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BBB48DE31E81124824B914AE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Summary:
   print bad BIOS maps (those containing overlaps in memory regions).

Kernel:
   linux-2.4.3-ac10

Description:
   This change informs the user when overlaping memory regions are
   found in an e820 memory map.  If overlaps are found, the mapping is
   displayed and then an adjusted map is created (without overlaps).
   If no overlaps are found, the original mapping is left untouched.

Brian
bmoyle@mvista.com
--------------BBB48DE31E81124824B914AE
Content-Type: application/octet-stream;
 name="patch-e820report.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch-e820report.bz2"

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
--------------BBB48DE31E81124824B914AE--

