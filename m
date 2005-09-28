Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVI1L1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVI1L1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 07:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVI1L1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 07:27:40 -0400
Received: from rusfw.rohde-schwarz.com ([80.246.32.32]:18772 "EHLO
	rusfw.rohde-schwarz.com") by vger.kernel.org with ESMTP
	id S1751213AbVI1L1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 07:27:40 -0400
Subject: smbfs 2 GB file size limitation in kernel 2.4.31?
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.5.4 March 27, 2005
Message-ID: <OFA0ECDBC1.CA6A5001-ONC125708A.003DE74A-C125708A.003EEBEE@rohde-schwarz.com>
From: Martin.Rauh@rsd.rohde-schwarz.com
Date: Wed, 28 Sep 2005 13:27:16 +0200
X-MIMETrack: Serialize by Router on RUS11/RUS(Release 6.5.4|March 27, 2005) at
 28.09.2005 13:27:39
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hello,

according to the changelog of kernel 2.4.25, smbfs should support large
files (>2GB?).
But if I mount a windows XP share on my linux box (kernel 2.4.31),
I still can not copy files larger than 2 GB to the mounted share.
The 'cp' command should work with large files,
because using 'cp' on a local reiserfs does work.

Does anybody know if there is still a 2 GB limitation in smbfs of 2.4.31
and
how to solve it?

Many thanks,

Martin Rauh

