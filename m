Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbRFZXuW>; Tue, 26 Jun 2001 19:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265152AbRFZXuN>; Tue, 26 Jun 2001 19:50:13 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12727 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264739AbRFZXuI>;
	Tue, 26 Jun 2001 19:50:08 -0400
Date: Wed, 27 Jun 2001 01:50:06 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106262350.BAA426810.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [OT] util-linux-2.11g
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just released: util-linux-2.11g

* MCONFIG & configure: fix for gcc 3.0
  Note that nfsmount_xdr.c may give warnings with gcc 3.0, essentially
  because of defines in <rpc/xdr.h> that use things like ntohl(*buf++)
  where ntohl(x) is a macro with several occurrences of x.
* blockdev: support for the get/set blocksize ioctls
  [not yet in the 2.4.5 kernel]
* fdisk: added Linux/PA-RISC type (Matt Taggart)
* mount: minor fix (Andrey J. Melnikoff)
* mount: added some ext3 stuff (Andrew Morton)
* mount: added heuristics for reiserfs (Andrew Morton)
* mount.8: added ext3 and reiserfs docs (Andrew Morton)
