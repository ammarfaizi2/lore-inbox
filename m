Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290297AbSAPAL5>; Tue, 15 Jan 2002 19:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290296AbSAPALs>; Tue, 15 Jan 2002 19:11:48 -0500
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:40207 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S290297AbSAPALf>; Tue, 15 Jan 2002 19:11:35 -0500
Message-ID: <3C44C4FD.7911F0CF@easynet.be>
Date: Wed, 16 Jan 2002 01:10:37 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre11-H7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
CC: Paul Bristow <paul@paulbristow.net>
Subject: IDE floppy broken in 2.5.2 & 2.5.3-pre1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE floppy is broken in 2.5.2 & 2.5.3-pre1.
More specifically, it oops/BUG_ON at the driver initialization
because the additional check made in elevator_linus_add_request()
between 2.5.2-pre11 and 2.5.2-final.

Further investigation is on the way.

-- 
Luc Van Oostenryck
