Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUENTYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUENTYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUENTYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:24:47 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:6309 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262213AbUENTYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:24:46 -0400
Message-ID: <40A51CFB.7000305@g-house.de>
Date: Fri, 14 May 2004 21:24:43 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6+ (Windows/20040504)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OT] "bk pull" does not update my sources...?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

being a beginner with Bitkeeper repositories i used to "clone" 
bk://linux.bkbits.net/linux-2.5 to my disk, then did "bk -r get" (as 
advised elsewhere) and do "bk pull" every now and then. but i noted the 
following:

evil@sheep:/usr/src/linux-2.6-BK$ date
Fr Mai 14 21:09:51 CEST 2004
evil@sheep:/usr/src/linux-2.6-BK$ bk pull
Pull bk://linux.bkbits.net/linux-2.5
   -> file://usr/src/linux-2.6-BK
Nothing to pull.
evil@sheep:/usr/src/linux-2.6-BK$ head -n5 Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 6
EXTRAVERSION =
NAME=Zonked Quokka
evil@sheep:/usr/src/linux-2.6-BK$

on kernel.org there is already a 2.6.6-bk1 snapshot-patch, it'd patch 
Makefile to show us "-bk1", but my local repository -just updated via 
bk- does still say "2.6.6". how comes?

i tried "bk co|get Makfefile", "bk check"...all seems to be well.

Thanks for helping,
Christian.

(ps: pm is also fine, as this is admittedly not a kernel-thing....)

-- 
BOFH excuse #3:

electromagnetic radiation from satellite debris

