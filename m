Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271401AbTGXBDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 21:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271403AbTGXBDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 21:03:00 -0400
Received: from mrout2.yahoo.com ([216.145.54.172]:8968 "EHLO mrout2.yahoo.com")
	by vger.kernel.org with ESMTP id S271401AbTGXBCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 21:02:54 -0400
Message-ID: <3F1F33B0.4070701@bigfoot.com>
Date: Wed, 23 Jul 2003 18:17:36 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SATA HD 137GB limitation?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   system:

   MB: intel D865PERL
   maxtor 250GB SATA drive (not a boot drive)
   kernel 2.4.21-ac4
   debian unstable

   normal kernels up to 2.4.21 freeze during HD detection, only 
2.4.21-ac4 properly detects the drive. All programs (mkfs, badblocks, 
cfdisk) recognize it as 250GB drive but none of them can read anything 
beyond 137GB. All programs (that I tried) report read failure when 
sectors above 137GB are being read.

   anybody knows the status of SATA driver(s)?

   TIA

	erik

