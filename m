Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbUKBLzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUKBLzB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 06:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUKBLzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 06:55:00 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:40078 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261207AbUKBLyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 06:54:46 -0500
Date: Tue, 2 Nov 2004 11:54:41 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
Cc: jonsmirl@gmail.com
Subject: [bk tree] drm core/personality split...
Message-ID: <Pine.LNX.4.58.0411021137120.25783@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay I've ported over the first chunk of work from Jon (with reorg by
me..) for the core/personality split for the DRM drivers,

The patch (>500K) is too big for LK so it is at
http://www.skynet.ie/~airlied/patches/dri/drm_core_split_bk-2.6.diff

It includes the other fixes from my bk tree also... the patch is huge as
it involves some file renames and removing all those DRM() macros changes
a lot of stuff, on a functionality level it shouldn't be that different,
the drm will now use 2.6 module parameters..

The bk tree is bk://drm.bkbits.net/drm-2.6, and will appear in Andrews
next -mm patch....

I'll be putting more changes in the next couple of days (fops move into
driver, maybe proper drm sysfs support, and getting rid of the
inter_module_register stuff...)

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

