Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271246AbRHTOh2>; Mon, 20 Aug 2001 10:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271244AbRHTOhT>; Mon, 20 Aug 2001 10:37:19 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:7657 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S271246AbRHTOhC>; Mon, 20 Aug 2001 10:37:02 -0400
Date: Mon, 20 Aug 2001 07:37:16 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: lnz@dandelion.com
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: linux-2.4.9/drivers/block/DAC960.c to new module_{init,exit} interface
Message-ID: <20010820073716.A329@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The following patch moves linux-2.4.9/drivers/block/DAC960.c
to the new module_{init,exit} interface, simplifying it slightly and
removing the DAC960_init reference from drivers/block/genhd.c
(part of my effort to eliminate genhd.c).

	Leonard, does this look OK to you?  If so, do you want to
submit this to Alan and Linus or do you want me to?

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
