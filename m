Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVGLX1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVGLX1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVGLXZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:25:06 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:16199 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262248AbVGLXYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:24:12 -0400
Date: Tue, 12 Jul 2005 19:24:12 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH/SCRIPT] reiserfs: run scripts/Lindent on reiserfs code
Message-ID: <20050712232412.GA9669@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.151-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The attached script runs scripts/Lindent against fs/reiserfs.c and
include/linux/reiserfs_*.h

It's a quick one-liner consisting of:

scripts/Lindent fs/reiserfs/*.c include/linux/reiserfs_*.h

-Jeff

-- 
Jeff Mahoney
SuSE Labs

--vkogqOf2sHV7VnPd
Content-Type: application/x-sh
Content-Disposition: attachment; filename="reiserfs-lindent.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Ascripts/Lindent fs/reiserfs/*.c include/linux/reiserfs_*.h=0A
--vkogqOf2sHV7VnPd--
