Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbWCXO2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbWCXO2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWCXO2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:28:00 -0500
Received: from vscan01.westnet.com.au ([203.10.1.131]:61326 "EHLO
	vscan01.westnet.com.au") by vger.kernel.org with ESMTP
	id S932650AbWCXO17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:27:59 -0500
Message-ID: <4424027E.7080103@snapgear.com>
Date: Sat, 25 Mar 2006 00:30:22 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.16-uc0 (MMU-less support)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.16.
There really isn't much in this at all. Just a couple of
recent minor bug fixes, everything else has been merged.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.16-uc0.patch.gz

Change log:

. import of 2.6.16                                 Greg Ungerer
. remove use of cli/sti in fec.c                   Roucaries Bastien
. reorder interrupt setup code in fec.c            Greg Ungerer
. switch to PER_LINUX_32BIT in binfmt_flat loader  Malcolm Parsons
. set physical memory base for M5208EVB            Greg Ungerer

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a division of Secure Computing  PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
