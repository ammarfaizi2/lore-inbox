Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRAaMRB>; Wed, 31 Jan 2001 07:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130924AbRAaMQw>; Wed, 31 Jan 2001 07:16:52 -0500
Received: from iupmime.univ-lemans.fr ([193.52.29.129]:5017 "EHLO
	iupmime.univ-lemans.fr") by vger.kernel.org with ESMTP
	id <S130154AbRAaMQk>; Wed, 31 Jan 2001 07:16:40 -0500
Date: Wed, 31 Jan 2001 13:18:07 +0100 (MET)
Message-Id: <200101311218.NAA14680@lucke.univ-lemans.fr>
From: Yann DRONEAUD <yann.droneaud@iupmime.univ-lemans.fr>
To: linux-kernel@vger.kernel.org
Subject: fs block/devfs check disc change
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a re-post

I found in 'fs/block_dev.c' there's a function  'check_disk_change' and 
        in 'fs/devfs/base.c' there's a function 'check_disc_changed'
They done exactly the same job. Their source code are quite the same.
I think that one of these must be rewritted to call/use the other and 
it's not to me to tell you which one :-).

--
Yann Droneaud <yann.droneaud@iupmime.univ-lemans.fr>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
