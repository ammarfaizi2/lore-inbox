Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbREUSu5>; Mon, 21 May 2001 14:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbREUSuk>; Mon, 21 May 2001 14:50:40 -0400
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:62197 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S261399AbREUSuE>; Mon, 21 May 2001 14:50:04 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.2.19+ide: corrupts ide tape output
From: Camm Maguire <camm@enhanced.com>
Date: 21 May 2001 14:49:55 -0400
In-Reply-To: Jan Hudec's message of "Mon, 21 May 2001 15:32:46 +0200"
Message-ID: <54r8xia65o.fsf_-_@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings!  2.2.19+ide, applied the patch because this box has a new
Promise PDC20267 ide controller.  14GB HP Colorado tape drive.  Before
we installed the new ide controller and patched the kernel, i.e. with
unpatched 2.2.19 running on a different ide controller, this setup
works just fine.  Now I get the following occasionally, which results
in corrupted dumps to tape:

May 21 10:27:47 intech9 kernel: hdh: status error: status=0x40 { DriveReady }
May 21 10:27:47 intech9 kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted

Any advice much appreciated!

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
