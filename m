Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751736AbWBEMDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbWBEMDq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 07:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWBEMDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 07:03:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:37789 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751733AbWBEMDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 07:03:45 -0500
Date: Sun, 5 Feb 2006 13:03:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future
 Linux (stirring up a hornets' nest) ]
In-Reply-To: <43DE2FA8.nail16ZB1XOPF@burner>
Message-ID: <Pine.LNX.4.61.0602051300430.11476@yvahk01.tjqt.qr>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <43DCA097.nailGPD11GI11@burner> <Pine.LNX.4.61.0601291212360.18492@yvahk01.tjqt.qr>
 <43DE2FA8.nail16ZB1XOPF@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I just found that the followig "works" (cdrom drive not supported, but 
other than that seems fine) under Solaris 11 snv_30 x86, much to my 
surprise:

  cdrecord -dev=/dev/rdsk/c1t0d0p0 -toc

which worked just as well as

  cdrecord -dev=1,0,0 -toc

I would have rather expected to get

  Warning: Open by 'devname' is unintentional and not supported.



Jan Engelhardt
-- 
