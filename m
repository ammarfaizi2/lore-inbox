Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbUL2IPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbUL2IPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 03:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbUL2IOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 03:14:00 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:32699 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261433AbUL2Hye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:54:34 -0500
Date: Wed, 29 Dec 2004 07:54:30 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com, torvalds@osdl.org
Subject: latest bk fails to build floppy modular...
Message-ID: <Pine.LNX.4.58.0412290751350.31647@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Latest bk tree just cloned fails to build a modular floppy

 CC [M]  drivers/block/floppy.o
/foo/airlied/bitkeeper/drm-latest/drivers/block/floppy.c: In function
`init_module':
/foo/airlied/bitkeeper/drm-latest/drivers/block/floppy.c:4598: error:
syntax error before "UTS_RELEASE"

Jeff your change to remove version.h looks like it only works for
non-modular floppy, I think it should be reverted, or the debugging
removed...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

