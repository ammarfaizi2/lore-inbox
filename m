Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTDTPeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 11:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbTDTPeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 11:34:16 -0400
Received: from mta05bw.bigpond.com ([139.134.6.95]:18170 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP id S263612AbTDTPeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 11:34:14 -0400
Message-ID: <3EA2C16A.2030609@snapgear.com>
Date: Mon, 21 Apr 2003 01:48:58 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.68-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.68.
Not much new since the last patch. Only minor fixups required.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.68-uc0.patch.gz

Change log:

. updated defconfig for the m68knommu arch
. ColdFire serial driver and console clean ups
. fix ColdFire timer warnings
. remove some inline mm stubs (specific to mmu-less support) from mm.h
. fix Dragon Engine 2 Makefile

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com


















