Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTJSUsI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 16:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbTJSUsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 16:48:08 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:7808
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262181AbTJSUsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 16:48:06 -0400
From: John Mock <kd6pag@qsl.net>
To: Harold Martin <cocoadev@earthlink.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mounting /dev/md0 as root in 2.6.0-test7
Message-Id: <E1ABKTE-0000O2-00@penngrove.fdns.net>
Date: Sun, 19 Oct 2003 13:48:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been corrected!  While /dev/md0 may not be correctly detected in
Macintosh (PPC) partitions, they should be recognized in MSDOS and SUN
partition tables.  You probably won't need a 'md0=...' command line for
most configurations.

I apologize for any confusion i may have created.  Thank you very much
for the correction, Andre.
				       -- JM


P.S.  I believe the relevant HOW-TO is:

    http://www.tldp.org/HOWTO/Boot+Root+Raid+LILO.html

    Boot+Root+Raid+LILO, Boot + Root + Raid + Lilo : Software Raid mini-HOWTO

    Updated: July 2000. A cookbook for setting up root raid using the 0.90
    raidtools for bootable raid mounted on root using standard LILO. 

Good luck!
